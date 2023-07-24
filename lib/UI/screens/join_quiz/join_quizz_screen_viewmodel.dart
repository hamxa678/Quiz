import 'package:Quizz/core/others/base_view_model.dart';
import 'package:Quizz/locator.dart';
import 'package:flutter/material.dart';

import '../../../core/services/firebase_service.dart';

class JoinQuizScreenViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final firebaseService = locator<FirebaseService>();

  TextEditingController qcController = TextEditingController();
}
