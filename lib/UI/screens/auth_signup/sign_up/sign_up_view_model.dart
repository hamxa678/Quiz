import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Quizz/UI/screens/root/root_screen.dart';
import 'package:Quizz/core/enums/view_state.dart';
import 'package:Quizz/core/models/body/signup_body.dart';
import 'package:Quizz/core/others/base_view_model.dart';
import 'package:Quizz/core/services/firebase_auth_service.dart';
import 'package:Quizz/core/services/file_picker_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../locator.dart';

class SignUpViewModel extends BaseViewModel {
  SignUpViewModel() {}

  /// Below line is used to get instance of our firebase auth service and file picker.
  final _firebaseAuthService = locator<FirebaseAuthService>();
  final _imagePickerService = locator<FilePickerService>();

  /// SignUp screen textfield controller
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// current date time for date picker initial date
  DateTime selectedDate = DateTime.now();

  /// SignUpBody model class object
  SignUpBody signUpBody = SignUpBody();

  /// form key for form validation
  final formKey = GlobalKey<FormState>();

  /// All menu items list for dropdown widget
  List<String> list = <String>['Male', 'Female', 'Other'];

  /// false for hiding password and true for showing password and false is default value
  bool isPasswordVisible = true;

  /// default gender is Male
  String? gender = "Male";

  /// below function is used to  toggle the dropdown value when user selects any value
  toggleDropDownValue(String value) {
    gender = value;
    notifyListeners();
  }

  ///  for toggling password visibility when user clicks on suffix icon
  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  /// below function is used to select the date
  // Future<void> selectDop(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );

  //   if (picked != null && picked != selectedDate) {
  //     selectedDate = picked;
  //     // dobController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
  //   }
  // }

  /// below function is used to request for sign up
  signUp() async {
    setState(ViewState.busy);
    bool response;
    response = await _firebaseAuthService.signupWithEmailAndPassword(SignUpBody(
        email: emailController.text,
        password: passwordController.text,
        name: fullNameController.text,
        username: userNameController.text));
    if (response) {
      print("User created");
      // Get.offAll(const RootScreen());
    }
    setState(ViewState.idle);
  }

  // isUserAlreadyExist(SignUpBody signUpBody) async {
  //   bool isUserExist =
  //       await _firebaseAuthService.isUserAlreadyExist(signUpBody.email);
  //   if (isUserExist) {
  //     Get.snackbar("Error", "User already exist");
  //   }
  // }

  /// below function is used to pick image from gallery
  pickImage() async {
    signUpBody.image = await _imagePickerService.pickImage();
    notifyListeners();
  }

  /// below function is used to dispose all the controllers
  @override
  void dispose() {
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
