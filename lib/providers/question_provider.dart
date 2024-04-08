import 'package:adv_basics/services/question_service.dart';
import 'package:adv_basics/models/question.dart';
import 'package:flutter/material.dart';

class QuestionProvider extends ChangeNotifier {
  List<Question> _questions = [];
  List<Question> get questions => _questions;

  set questions(List<Question> questions) {
    if (questions.isNotEmpty) {
      _questions = questions;
    }
  }

  Future<List<Question>> getQuestions() async {
    final response = await fetchQuestions();
    _questions = response;
    notifyListeners();
    return _questions;
  }

  List<String> getShuffledAnswers(List<String> answers) {
    List<String> shuffledAnswers = answers;
    shuffledAnswers.shuffle();
    notifyListeners();
    return shuffledAnswers;
  }

  List<String> getAnswers(List<dynamic> incAnswers, String corAnswer) {
    List<String> answers = incAnswers.cast();
    answers.insert(0, corAnswer);
    notifyListeners();
    return answers;
  }
}
