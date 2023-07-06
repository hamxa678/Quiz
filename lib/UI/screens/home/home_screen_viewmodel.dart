import 'package:Quizz/core/others/base_view_model.dart';

class HomeScreenViewModel extends BaseViewModel {
  int currentIndex = 0;

  updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
