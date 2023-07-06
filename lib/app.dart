import 'package:flutter/material.dart';
import 'package:Quizz/UI/screens/auth_signup/sign_up/sign_up_screen.dart';
import 'package:Quizz/UI/screens/select_upload_avatar/select_avatar.dart';
import 'package:Quizz/UI/screens/select_upload_avatar/upload_avatar.dart';
import 'package:Quizz/UI/screens/splash_screen.dart';
import 'package:Quizz/core/services/localization_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'UI/screens/home/home_screen.dart';

class MyApp extends StatelessWidget {
  final String title;

  // Design width and height: you can edit them as per your required design
  static const double _designWidth = 375;
  static const double _designHeight = 812;

  const MyApp({required this.title, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// Initialize the screen util, this will make your UI responsive.
    return ScreenUtilInit(
      designSize: const Size(_designWidth, _designHeight),
      builder: (context, widget) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: LocalizationService(),
        locale: const Locale("en"),
        title: title,
        home: const HomeScreen(),
        // const SignUpScreen()
        // const SplashScreen(),
      ),
    );
  }
}
