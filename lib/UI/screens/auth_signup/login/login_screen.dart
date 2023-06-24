import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/custom_button.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/custom_textfield.dart';
import 'package:flutter_mvvm_template/UI/screens/auth_signup/login/login_view_model.dart';
import 'package:flutter_mvvm_template/UI/screens/auth_signup/sign_up/sign_up_screen.dart';
import 'package:flutter_mvvm_template/core/constants/strings.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/extensions/string_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        '${staticIcon}logo1.svg',
                        fit: BoxFit.scaleDown,
                      ),
                      42.verticalSpace,
                      Text(
                        'Login to your account',
                        style: TextStyle(
                          fontSize: 36.sp,
                          color: Colors.white,
                        ),
                      ),
                      37.verticalSpace,
                      CustomTextField(
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
                        hintText: 'Password',
                        controller: model.passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      10.verticalSpace,
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      36.verticalSpace,
                      CustomButton(
                        titleWidget: model.state == ViewState.busy
                            ? const CircularProgressIndicator(
                                color: Color(0xff4530B2),
                              )
                            : Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  color: const Color(0xff4530B2),
                                ),
                              ),
                        onPressed: () {
                          if (model.formKey.currentState!.validate()) {
                            // do something
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
