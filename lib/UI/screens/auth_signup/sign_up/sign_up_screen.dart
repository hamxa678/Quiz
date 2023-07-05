import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/custom_button.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/custom_textfield.dart';
import 'package:flutter_mvvm_template/UI/screens/auth_signup/login/login_screen.dart';
import 'package:flutter_mvvm_template/UI/screens/auth_signup/sign_up/sign_up_view_model.dart';
import 'package:flutter_mvvm_template/core/constants/strings.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/extensions/string_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
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
                child: Form(
                  key: model.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          '${staticIcon}logo1.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        42.verticalSpace,
                        Text(
                          'Register your account',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 36.sp,
                            color: Colors.white,
                          ),
                        ),
                        37.verticalSpace,
                        CustomTextField(
                          prefexIcon: SvgPicture.asset(
                            height: 20.h,
                            width: 13.96.w,
                            '${staticIcon}email.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: 'Full name',
                          controller: model.fullNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Fullname cannot be empty';
                            } else if (!value.isValidFullName()) {
                              return 'Please enter a valid name';
                            }
                            return null;
                          },
                        ),
                        20.verticalSpace,
                        CustomTextField(
                          prefexIcon: SvgPicture.asset(
                            height: 20.h,
                            width: 13.96.w,
                            '${staticIcon}email.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: 'Username',
                          controller: model.userNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username cannot be empty';
                            } else if (!value.isValidUserName()) {
                              return 'Please enter a valid username';
                            }
                            return null;
                          },
                        ),
                        20.verticalSpace,
                        CustomTextField(
                          prefexIcon: SvgPicture.asset(
                            height: 20.h,
                            width: 13.96.w,
                            '${staticIcon}email.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: 'Email',
                          controller: model.emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email cannot be empty';
                            } else if (!value.isEmail) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        20.verticalSpace,
                        CustomTextField(
                          prefexIcon: SvgPicture.asset(
                            height: 20.h,
                            width: 13.96.w,
                            '${staticIcon}password.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              model.togglePasswordVisibility();
                            },
                            child: model.isPasswordVisible
                                ? SvgPicture.asset(
                                    '${staticIcon}eye.svg',
                                    fit: BoxFit.scaleDown,
                                    color: const Color(0xffD9D9D9),
                                  )
                                : SvgPicture.asset('${staticIcon}eye-off.svg',
                                    fit: BoxFit.scaleDown,
                                    color: const Color(0xffD9D9D9)),
                          ),
                          hintText: 'Password',
                          controller: model.passwordController,
                          obscureText: model.isPasswordVisible,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password cannot be empty';
                            } else if (!value.isValidPassword()) {
                              return 'Password must be at least 8 characters (uppercase, lowercase, number and special character)';
                            }
                            return null;
                          },
                        ),
                        20.verticalSpace,
                        CustomTextField(
                          prefexIcon: SvgPicture.asset(
                            height: 20.h,
                            width: 13.96.w,
                            '${staticIcon}password.svg',
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: 'Confirm Password',
                          validator: (value) {
                            if (value != model.passwordController.text) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                        ),
                        36.verticalSpace,
                        CustomButton(
                          titleWidget: model.state == ViewState.busy
                              ? const CircularProgressIndicator(
                                  color: Color(0xff4530B2),
                                )
                              : Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff4530B2),
                                  ),
                                ),
                          onPressed: () {
                            if (model.formKey.currentState!.validate()) {
                              // model.loginWithEmailAndPassword();
                            }
                          },
                        ),
                        15.verticalSpace,
                        _dontHaveAccount(),
                        25.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _dontHaveAccount() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Already have an account? ",
            style: TextStyle(color: Color(0xffD9D9D9), fontFamily: 'Poppins'),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const LoginScreen());
            },
            child: const Text(
              'Login',
              style: TextStyle(
                  color: Color(0xffD9D9D9),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}





// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mvvm_template/UI/custom_widget/custom_button.dart';
// import 'package:flutter_mvvm_template/UI/custom_widget/custom_textfield.dart';
// import 'package:flutter_mvvm_template/UI/screens/auth_signup/login/login_screen.dart';
// import 'package:flutter_mvvm_template/UI/screens/auth_signup/sign_up/sign_up_view_model.dart';
// import 'package:flutter_mvvm_template/core/constants/strings.dart';
// import 'package:flutter_mvvm_template/core/enums/view_state.dart';
// import 'package:flutter_mvvm_template/core/extensions/string_extension.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_svg/svg.dart';

// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({Key? key, }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => SignUpViewModel(),
//       child: Consumer<SignUpViewModel>(
//         builder: (context, model, child) => Scaffold(
//           backgroundColor: Colors.white,
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(25.w, 65.h, 25.w, 0),
//               child: Form(
//                 key: model.formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       '${staticIcon}logo1.svg',
//                       fit: BoxFit.scaleDown,
//                     ),
//                     42.verticalSpace,
//                     Text(
//                       'Login to your account',
//                       style: TextStyle(
//                         fontSize: 36.sp,
//                         color: Colors.white,
//                       ),
//                     ),
//                     37.verticalSpace,
//                     Image.asset(
//                       '${staticImage}logo.png',
//                       cacheHeight: 449,
//                       cacheWidth: 406,
//                       height: 100.h,
//                       width: 100.w,
//                       fit: BoxFit.scaleDown,
//                     ),
//                     SizedBox(height: 50.h),
//                     SizedBox(height: 30.h),
//                     CustomTextField(
//                       validator: (input) =>
//                           input!.isValidEmail() ? null : "Invalid Email",
//                       keyboardtype: TextInputType.emailAddress,
//                       hintText: 'Email (i.e. johndoe@gmail.com)',
//                       controller: model.emailController,
//                     ),
//                     SizedBox(height: 20.h),
                   
//                     CustomTextField(
//                       validator: (input) =>
//                           input!.isValidUserName() ? null : "Invalid Name",
//                       hintText: 'Name',
//                       controller: model.nameController,
//                     ),
//                     SizedBox(height: 20.h),

//                     CustomTextField(
//                       validator: (input) {
//                         if (input!.isEmpty) {
//                           return "Please enter your location";
//                         }
//                         return null;
//                       },
//                       hintText: 'Location',
//                       controller: model.locationController,
//                     ),
//                     SizedBox(height: 20.h),
//                     _customDropDown(model),
//                     SizedBox(height: 20.h),
//                     CustomTextField(
//                       validator: (input) =>
//                           input!.isValidPhone() ? null : "Invalid Phone Number",
//                       hintText: 'Phone Number',
//                       controller: model.phoneNoController,
//                     ),
//                     SizedBox(height: 20.h),
//                     CustomTextField(
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter your DOB";
//                         } else if (value ==
//                             DateFormat('dd-MM-yyyy').format(DateTime.now())) {
//                           return "Please enter valid DOB";
//                         }
//                         return null;
//                       },
//                       readOnly: true,
//                       onTap: () {
//                         model.selectDop(context);
//                       },
//                       keyboardtype: TextInputType.datetime,

//                       //validator: model.inputValidation.validateEmail,
//                       onSaved: (dob) {
//                         //model.loginBody.email = email;
//                       },
//                       controller: model.dobController,
//                       hintText: "DOB (i.e. DD/MM/YYYY)",
//                     ),
//                     SizedBox(height: 30.h),

//                     // 55.verticalSpace,
//                     CustomButton(
//                       titleWidget: !(model.state == ViewState.busy)
//                           ? Text(
//                               'Sign Up' ,
//                               style: TextStyle(
//                                   fontSize: 20.sp, color: Colors.white),
//                             )
//                           : const CircularProgressIndicator(
//                               color: Colors.white),
//                       onPressed: () async {
//                         if (model.formKey.currentState!.validate()) {
//                           // await model.login();
//                           await model.signUp();
//                         }
//                       },
//                     ),
//                     SizedBox(height: 20.h),
//                     _alreadyHaveAccount()
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _alreadyHaveAccount() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text(
//             'Already have account? ',
//           ),
//           InkWell(
//             onTap: () {
//               Get.to(() => const LoginScreen());
//             },
//             child: const Text(
//               'Login',
//               style: TextStyle(color: Color(0xff2441A3)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Container _customDropDown(SignUpViewModel model) {
//     return Container(
//       height: 50.h,
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(60.r),
//           border: Border.all(color: const Color(0xff707070))),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: model.gender,
//           elevation: 16,
//           style: TextStyle(
//             fontSize: 15.sp,
//             color: const Color(0xff0D0F23),
//           ),
//           onChanged: (String? value) {
//             model.toggleDropDownValue(value!);
//           },
//           items: model.list.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
