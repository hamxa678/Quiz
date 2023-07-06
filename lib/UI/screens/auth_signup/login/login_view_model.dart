import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:Quizz/UI/screens/auth_signup/sign_up/sign_up_screen.dart';
import 'package:Quizz/UI/screens/root/root_screen.dart';
import 'package:Quizz/core/enums/view_state.dart';
import 'package:Quizz/core/models/body/login_body.dart';
import 'package:Quizz/core/others/base_view_model.dart';
import 'package:Quizz/core/services/firebase_auth_service.dart';
import 'package:Quizz/locator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoginViewModel extends BaseViewModel {
  final log = Logger();
  FirebaseAuthService firebaseAuthService = locator<FirebaseAuthService>();
  LoginBody loginBody = LoginBody();
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;

  /// skillsAndProjectsController screen textfield controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///  for toggling password visibility
  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  /// login with email and password
  loginWithEmailAndPassword() async {
    setState(ViewState.busy);
    loginBody.email = emailController.text;
    loginBody.password = passwordController.text;
    bool successLogin =
        await firebaseAuthService.loginWithEmailAndPassword(loginBody);
    if (successLogin) {
      Get.offAll(const RootScreen());
    }
    setState(ViewState.idle);
  }

  /// login with google
  loginWithGoogle() async {
    User? user = await firebaseAuthService.signInWithGoogle();

    bool routeToRoot = await firebaseAuthService.isRecordExist();
    if (user != null) {
      (routeToRoot)
          ? Get.offAll(const RootScreen())
          : Get.to(const SignUpScreen());
    }
  }

  /// dispose controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
