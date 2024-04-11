import 'package:adv_basics/models/question.dart';
import 'package:adv_basics/providers/question_provider.dart';
import 'package:adv_basics/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizProvider extends ChangeNotifier {
  var activeScreen = 'home-screen';
  var currentQuestionIndex = 0;
  List<String> selectedAnswers = [];

  Widget screenWidget = HomeScreen();

  void switchScreen() {
    activeScreen = 'questions-screen';

    notifyListeners();
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == 10) {
      activeScreen = 'results-screen';
    }
    notifyListeners();
  }

  void answerQuestion(String selectedAnswer) {
    chooseAnswer(selectedAnswer);

    currentQuestionIndex++;
    notifyListeners();
  }

  void restartQuiz() {
    currentQuestionIndex = 0;
    selectedAnswers = [];
    activeScreen = 'home-screen';

    notifyListeners();
  }
}
