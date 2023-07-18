import 'package:Quizz/core/enums/view_state.dart';
import 'package:Quizz/core/models/quiz_question_model.dart';
import 'package:Quizz/core/others/base_view_model.dart';
import 'package:Quizz/core/services/firebase_service.dart';
import 'package:Quizz/locator.dart';
import 'package:flutter/material.dart';

class CreateQuizScreenViewModel extends BaseViewModel {
  final firebaseService = locator<FirebaseService>();
  List<QuizQuestionModel> quizQuestionList = [
    QuizQuestionModel(options: [Options()], correctOption: 1)
  ];
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // int numberOfQuestion = 1;

  incrementQuestion() {
    quizQuestionList
        .add(QuizQuestionModel(options: [Options()], correctOption: 1));
    notifyListeners();
  }

  incrementOption(int index) {
    quizQuestionList[index].options!.add(Options());
    notifyListeners();
  }

  deleteQuestion(int index) {
    quizQuestionList.removeAt(index);
    notifyListeners();
  }

  deleteOption(int index, int optionIndex) {
    quizQuestionList[index].options!.removeAt(optionIndex);
    notifyListeners();
  }

  toggleCorrectOption(int index, int optionIndex) {
    quizQuestionList[index].correctOption = optionIndex + 1;
    notifyListeners();
  }

  createQuiz(String title, String description) async {
    setState(ViewState.busy);
    await firebaseService.createQuiz(quizQuestionList, title, description);
    setState(ViewState.idle);
  }
}
