// import 'package:Quizz/core/enums/view_state.dart';
import 'package:Quizz/core/enums/view_state.dart';
import 'package:Quizz/core/others/base_view_model.dart';
import 'package:Quizz/core/services/firebase_auth_service.dart';
import 'package:Quizz/core/services/firebase_service.dart';
import 'package:Quizz/locator.dart';

class HomeScreenViewModel extends BaseViewModel {
  HomeScreenViewModel() {
    getTeacherQuizzes();
  }
  dynamic teacherQuizzesStream;
  FirebaseAuthService firebaseAuthService = locator<FirebaseAuthService>();
  FirebaseService firebaseService = locator<FirebaseService>();
  int currentIndex = 0;

  getTeacherQuizzes() {
    teacherQuizzesStream = firebaseService.getQuizzesStreamForTeacher();
  }

  deleteQuiz(String quizId) async {
    setState(ViewState.busy);
    await firebaseService.deleteQuiz(quizId);
    setState(ViewState.idle);
  }

  updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
