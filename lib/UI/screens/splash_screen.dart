import 'package:Quizz/UI/screens/home/home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:Quizz/UI/custom_widget/dialogbox/network_error_dialog.dart';
import 'package:Quizz/UI/screens/auth_signup/login/login_screen.dart';
import 'package:Quizz/UI/screens/onboarding/onboarding_screen.dart';
import 'package:Quizz/UI/screens/root/root_screen.dart';
import 'package:Quizz/core/constants/colors.dart';
import 'package:Quizz/core/constants/strings.dart';
import 'package:Quizz/core/models/other_models/onboarding.dart';
import 'package:Quizz/core/others/logger_customizations/custom_logger.dart';
import 'package:Quizz/core/services/firebase_auth_service.dart';
import 'package:Quizz/core/services/local_storage_service.dart';
import 'package:Quizz/core/services/notifications_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../locator.dart';
import 'select_upload_avatar/select_avatar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _FirebaseAuthService = locator<FirebaseAuthService>();
  final _localStorageService = locator<LocalStorageService>();
  final _notificationService = locator<NotificationsService>();
  List<Onboarding> onboardingList = [];
  final Logger log = CustomLogger(className: 'Splash Screen');

  @override
  void didChangeDependencies() {
    _initialSetup();
    super.didChangeDependencies();
  }

  _initialSetup() async {
    await _localStorageService.init();

    ///
    /// If not connected to internet, show an alert dialog
    /// to activate the network connection.
    ///
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Get.dialog(const NetworkErrorDialog());
      return;
    }

    ///
    ///initializing notification services
    ///

    // await _notificationService.initConfigure();

    ///
    /// Use the below [_getOnboardingData] method if the
    /// onboarding is dynamic (Means onboarding data coming from
    /// the apis)
    ///
    onboardingList = await _getOnboardingData();

    ///
    /// Routing to the last onboarding screen user seen
    ///
    if (_localStorageService.onBoardingPageCount + 1 < onboardingList.length) {
      ///
      /// For better user experience we precache onboarding images in case
      /// they are coming from a remote server.
      /// Remove it if onboarding is static.
      ///
      final List<Image> preCachedImages =
          await _preCacheOnboardingImages(onboardingList);
      await Get.to(() => OnboardingScreen(
          currentIndex: _localStorageService.onBoardingPageCount,
          onboardingList: onboardingList,
          preCachedImages: preCachedImages));
      return;
    }
    await _FirebaseAuthService.doSetup();

    ///
    ///checking if the user is login or not
    ///
    log.d('@_initialSetup. Login State: ${_FirebaseAuthService.isLogin}');
    if (!_FirebaseAuthService.isLogin) {
      Get.off(() => const LoginScreen());
    } else if (_FirebaseAuthService.isAvatarUploaded) {
      Get.off(() => const HomeScreen());
    } else {
      Get.off(() => const SelectAvatarScreen());
    }
  }

  // _FirebaseAuthService.isLogin

  Future<List<Image>> _preCacheOnboardingImages(
      List<Onboarding> onboardingList) async {
    List<Image> preCachedImages =
        onboardingList.map((e) => Image.network(e.imgUrl!)).toList();
    for (Image preCacheImg in preCachedImages) {
      await precacheImage(preCacheImg.image, context);
    }
    return preCachedImages;
  }

  // ignore: unused_element
  _getOnboardingData() async {
    ///uncomment below code

    // final response = await _dbService.getOnboardingData();
    // if (response.success) {
    //   return response.onboardingsList;
    // } else {
    //   return [];
    // }
    List<Onboarding> onboardings = [];
    return onboardings;
  }

  @override
  Widget build(BuildContext context) {
    /// Splash Screen UI goes here.
    return Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: Stack(
          children: [
            Image.asset(
              '${staticImage}Background.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Center(
              child: SvgPicture.asset(
                '${staticIcon}logo.svg',
                height: 75.h,
                width: 165.42.w,
                fit: BoxFit.scaleDown,
              ),
            )
          ],
        ));
  }
}
