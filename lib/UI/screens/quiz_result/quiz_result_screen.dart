import 'package:Quizz/core/constants/strings.dart';
import 'package:Quizz/core/models/quiz_result.dart';
import 'package:Quizz/core/others/base_view_model.dart';

class ResultScreenViewModel extends BaseViewModel {
  List<QuizResultModel> result = [
    QuizResultModel(
        image: '${staticImage}1st.png', name: 'Hamza Khan', scorePercent: 100),
    QuizResultModel(
        image: '${staticImage}ava1.png', name: 'Hamza Kamal', scorePercent: 90),
    QuizResultModel(
        image: '${staticImage}ava2.png', name: 'Amir Khayam', scorePercent: 80),
    QuizResultModel(
        image: '${staticImage}ava3.png', name: 'Ejaz Khan', scorePercent: 70),
    QuizResultModel(
        image: '${staticImage}ava4.png', name: 'Mahed Ali', scorePercent: 60),
    QuizResultModel(
        image: '${staticImage}ava5.png', name: 'Hamza Khan', scorePercent: 50),
    QuizResultModel(
        image: '${staticImage}ava6.png', name: 'Hamza Khan', scorePercent: 40),
    QuizResultModel(
        image: '${staticImage}ava7.png', name: 'Hamza Khan', scorePercent: 30),
    QuizResultModel(
        image: '${staticImage}ava8.png', name: 'Hamza Khan', scorePercent: 20),
    QuizResultModel(
        image: '${staticImage}ava9.png', name: 'Hamza Khan', scorePercent: 10),
  ];
}
