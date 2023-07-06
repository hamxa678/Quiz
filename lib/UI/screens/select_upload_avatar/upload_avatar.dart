import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/custom_button.dart';
import 'package:flutter_mvvm_template/UI/screens/select_upload_avatar/select_avatar_viewmodel.dart';
import 'package:flutter_mvvm_template/core/constants/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadAvatarScreen extends StatelessWidget {
  const UploadAvatarScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectAvatarViewModel(),
      child: Consumer<SelectAvatarViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              height: 1.sh,
              width: 1.sw,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('${staticImage}Background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(25.w, 65.h, 25.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            '${staticIcon}logo1.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          const Spacer(),
                          _skipButton(),
                        ],
                      ),
                      42.verticalSpace,
                      Text(
                        'Upload your avatar',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 36.sp,
                          color: Colors.white,
                        ),
                      ),
                      75.verticalSpace,
                      _uploadAvatar(),
                      131.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          // do something
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Select your avatar',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      37.verticalSpace,
                      CustomButton(
                        titleWidget: const Text(
                          'Upload',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Color(0xff4530B2),
                          ),
                        ),
                        onPressed: () {
                          // do something
                        },
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget _uploadAvatar() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          // do something
        },
        child: Image.asset(
          '${staticImage}avatar.png',
          height: 185.02.h,
          width: 176.w,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  GestureDetector _skipButton() {
    return GestureDetector(
      onTap: () {
        // do something
      },
      child: Row(
        children: [
          Text(
            'Skip',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 24.sp,
              color: Colors.white,
            ),
          ),
          9.horizontalSpace,
          SvgPicture.asset(
            '${staticIcon}skip.svg',
            fit: BoxFit.scaleDown,
          ),
        ],
      ),
    );
  }
}
