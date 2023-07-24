import 'package:Quizz/UI/screens/join_quiz/joined_quiz_screen.dart';
import 'package:Quizz/core/enums/view_state.dart';
import 'package:Quizz/core/models/quiz_model.dart';
import 'package:Quizz/core/others/base_view_model.dart';
import 'package:Quizz/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/firebase_service.dart';

class JoinQuizScreenViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final firebaseService = locator<FirebaseService>();
  DocumentReference? quizDocumentRefererace;
  QuizModel? quizResponse;
  TextEditingController qcController = TextEditingController();

  getQuizQuestion() async {
    setState(ViewState.busy);
    quizDocumentRefererace =
        firebaseService.getQuizDocRefererence(qcController.text);
    await quizDocumentRefererace!.get().then((value) {
      quizResponse = QuizModel.fromMap(value.data()!);
      notifyListeners();
    }).whenComplete(() {
      Get.snackbar("Success", 'Quiz joined successfully');
    });
    notifyListeners();
    setState(ViewState.idle);
  }

  // Future<UserProfile> getUserProfile() async {
  //   await documentReferenceForUser.get().then((value) {
  //     userProfile = UserProfile.fromMap(value.data());
  //   });
}
