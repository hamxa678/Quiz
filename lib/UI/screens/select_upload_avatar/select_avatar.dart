import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/custom_button.dart';
import 'package:flutter_mvvm_template/UI/screens/select_upload_avatar/select_avatar_viewmodel.dart';
import 'package:flutter_mvvm_template/core/constants/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectAvatarScreen extends StatelessWidget {
  const SelectAvatarScreen({Key? key}) : super(key: key);
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
                        'Select your avatar',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 36.sp,
                          color: Colors.white,
                        ),
                      ),
                      24.verticalSpace,
                      GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 0),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 95.w / 96.h,
                            crossAxisCount: 3,
                            crossAxisSpacing: 20.w,
                            mainAxisSpacing: 23.h),
                        children: List.generate(model.avatars.length, (index) {
                          return GestureDetector(
                              onTap: () {
                                // do something
                              },
                              child: Image.asset(model.avatars[index]));
                        }),
                      ),
                      24.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          // do something
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Upload your avatar',
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
                          'Select',
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
