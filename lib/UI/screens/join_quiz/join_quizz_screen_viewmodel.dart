import 'package:Quizz/UI/screens/home/home_screen.dart';
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
  DocumentReference? submitQuizDocumentRefererace;
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
        // qcController.clear();
      } else {
        Get.snackbar("Error", 'Quiz not found');
      }
    });
    notifyListeners();
    setState(ViewState.idle);
  }

  selectOption(questionIndex, optionIndex) {
    quizQuestionListResponse![questionIndex].selectedOption = optionIndex;
    notifyListeners();
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

  submitQuiz() {
    setState(ViewState.busy);
    submitQuizDocumentRefererace =
        firebaseService.getSubmitQuizDocRefererence(qcController.text);
    submitQuizDocumentRefererace!.set({
      'quiz': quizResponse!.toMap(),
      // 'questions': quizQuestionListResponse!.map((e) => e.toMap()).toList(),
      'user': firebaseService.currentUser!.uid,
      'userName': firebaseService.userProfile.name,
      'userEmail': firebaseService.userProfile.email,
      'userPhotoUrl': firebaseService.userProfile.profileImageUrl,
      'userScore': getScore(),
      'totalScore': quizQuestionListResponse!.length,
      'quizCode': qcController.text,
      'quizName': quizResponse!.title,
      'quizDescription': quizResponse!.description,
      // 'quizDuration': quizResponse!.quizDuration,
      // 'quizType': quizResponse!.quizType,
      // 'quizCategory': quizResponse!.quizCategory,
      // 'quizSubCategory': quizResponse!.quizSubCategory,
      // 'quizDifficulty': quizResponse!.quizDifficulty,
      // 'quizLanguage': quizResponse!.quizLanguage,
      // 'quizQuestions': quizResponse!.quizQuestions,
      // 'quizTotalQuestions': quizResponse!.quizTotalQuestions,
      // 'quizTotalMarks': quizResponse!.quizTotalMarks,
      // 'quizTotalTime': quizResponse!.quizTotalTime,
      // 'quizTotalAttempts': quizResponse!.quizTotalAttempts,
      // 'quizTotalParticipants': quizResponse!.quizTotalParticipants,
      // 'quizTotalLikes': quizResponse!.quizTotalLikes,
      // 'quizTotalDislikes': quizResponse!.quizTotalDislikes,
      // 'quizTotalComments': quizResponse!.quizTotalComments,
      // 'quizTotalShares': quizResponse!.quizTotalShares,
      // 'quizTotalViews': quizResponse!.quizTotalViews,
      // 'quizTotalQuestionsAnswered': quizResponse!.quizTotalQuestionsAnswered,
      // 'quizTotalQuestionsCorrect': quizResponse!.quizTotalQuestionsCorrect,
      // 'quizTotalQuestionsIncorrect': quizResponse!.quizTotalQuestionsIncorrect,
      // 'quizTotalQuestionsUnanswered':
      //     quizResponse!.quizTotalQuestionsUnanswered,
      // 'quizTotalMarksScored': quizResponse!.quizTotalMarksScored,
      // 'quizTotalMarksObtained': quizResponse!.quizTotalMarksObtained,
      // 'quizTotalMarksPercentage': quizResponse!.quizTotalMarksPercentage,
      // 'quizTotalTimeTaken': quizResponse!.quizTotalTimeTaken,
      // 'quizTotalTimePercentage': quizResponse!.quizTotalTimePercentage,
      // 'quizTotalAttemptsPercentage': quiz
    }).whenComplete(() {
      // quizQuestionListResponse!.forEach((element) async {
      //   await submitQuizDocumentRefererace!
      //       .collection('questions')
      //       .doc(quizQuestionListResponse!.indexOf(element).toString()).set(
      //         element.toMap(),
      //       );
      // });
      Get.offAll(() => const HomeScreen());

      Get.snackbar('Success', 'Quiz submitted successfully');
    });
    setState(ViewState.idle);
  }

  int getScore() {
    // int userScore = 0;
    int userScore = 0;

    for (int i = 0; i < quizQuestionListResponse!.length; i++) {
      // print('Correct Answer');
      if (quizQuestionListResponse![i].selectedOption! + 1 ==
          quizQuestionListResponse![i].correctOption) {
        // print('Correct Answer');
        userScore++;
      }
    }
    return userScore;
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
