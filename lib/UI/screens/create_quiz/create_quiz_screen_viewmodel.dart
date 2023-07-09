import 'package:Quizz/core/models/quiz_question_model.dart';
import 'package:Quizz/core/others/base_view_model.dart';

class CreateQuizScreenViewModel extends BaseViewModel {
  List<QuizQuestionModel> quizQuestionList = [
    QuizQuestionModel(options: [Options()], correctOption: 1)
  ];
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
}
