import 'package:Quizz/UI/screens/join_quiz/joined_quiz_screen.dart';
import 'package:Quizz/core/enums/view_state.dart';
import 'package:Quizz/core/models/quiz_model.dart';
import 'package:Quizz/core/models/quiz_question_model.dart';
import 'package:Quizz/core/others/base_view_model.dart';
import 'package:Quizz/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/firebase_service.dart';

class JoinQuizScreenViewModel extends BaseViewModel {
  final firebaseService = locator<FirebaseService>();
  DocumentReference? quizDocumentRefererace;
  QuizModel? quizResponse;
  List<QuizQuestionModel>? quizQuestionListResponse;
  TextEditingController qcController = TextEditingController();

  Future getQuizDetail() async {
    setState(ViewState.busy);
    quizDocumentRefererace =
        firebaseService.getQuizDocRefererence(qcController.text);
    await quizDocumentRefererace!.get().then((value) {
      quizResponse = QuizModel.fromMap(value.data()!);
      notifyListeners();
    }).whenComplete(() async {
      if (quizResponse != null) {
        await _getQuizQuestions();
        Get.snackbar("Success", 'Quiz joined successfully');
        Get.off(const JoinedQuizScreen());
        qcController.clear();
      } else {
        Get.snackbar("Error", 'Quiz not found');
      }
    });
    notifyListeners();
    setState(ViewState.idle);
  }

  Future _getQuizQuestions() async {
    // print('Getting questions');
    setState(ViewState.busy);
    await quizDocumentRefererace!.collection('questions').get().then((value) {
      quizQuestionListResponse = [];
      value.docs.forEach((element) {
        // quizQuestionListResponse = [];
        quizQuestionListResponse!
            .add(QuizQuestionModel.fromMap(element.data()));
        // print(quizQuestionListResponse![0].options![0]['option']);
      });
    });
    setState(ViewState.idle);
  }

  // void copyFrom(JoinQuizScreenViewModel other) {
  //   quizResponse = other.quizResponse;
  //   // Copy the relevant properties from 'other' to 'this'
  //   // Example:
  //   // this.someProperty = other.someProperty;
  //   // this.anotherProperty = other.anotherProperty;
  // }

  // Future<UserProfile> getUserProfile() async {
  //   await documentReferenceForUser.get().then((value) {
  //     userProfile = UserProfile.fromMap(value.data());
  //   });
}
