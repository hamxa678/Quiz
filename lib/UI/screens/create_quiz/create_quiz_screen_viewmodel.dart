import 'package:Quizz/core/others/base_view_model.dart';

class CreateQuizScreenViewModel extends BaseViewModel {
  int numberOfQuestion = 1;

  incrementNumberOfQuestion() {
    numberOfQuestion++;
    notifyListeners();
  }
}
