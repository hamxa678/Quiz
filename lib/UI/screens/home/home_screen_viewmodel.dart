import 'package:Quizz/core/others/base_view_model.dart';
import 'package:Quizz/core/services/firebase_auth_service.dart';
import 'package:Quizz/core/services/firebase_service.dart';
import 'package:Quizz/locator.dart';

class HomeScreenViewModel extends BaseViewModel {
  FirebaseAuthService firebaseAuthService = locator<FirebaseAuthService>();
  FirebaseService firebaseService = locator<FirebaseService>();
  int currentIndex = 0;

  updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
