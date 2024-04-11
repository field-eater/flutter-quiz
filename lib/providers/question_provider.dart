import 'dart:convert';

import 'package:adv_basics/models/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class QuestionProvider extends ChangeNotifier {
  List<Question> _questions = [];
  List<Question> get questions => _questions;
  String api = dotenv.env['API_URL'] as String;

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

  Future<int> getQuestionLength() async {
    final response = await getQuestions();
    _questions = response;
    notifyListeners();
    return _questions.length;
  }

  List<String> getAnswers(List<dynamic> incAnswers, String corAnswer) {
    final List<String> answers = incAnswers.cast();
    if (!answers.contains(corAnswer)) {
      answers.insert(0, corAnswer);
    }
    notifyListeners();
    return answers;
  }

  Future<List<Question>> fetchQuestions() async {
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final request = json.decode(response.body)['results'];
      List<Question> questions = [];

      request.forEach((element) => questions.add(Question.fromJson(element)));

      return questions;
    } else {
      throw Exception('Failed to load question');
    }
  }
}
