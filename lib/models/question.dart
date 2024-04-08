import 'package:flutter/material.dart';

class Question {
  Question({
    required this.question,
    required this.index,
    required this.correctAnswer,
    required this.answers,
    // required this.incorrectAnswers,
  });
  final int index;
  final String question;
  final List<dynamic> answers;
  // final List<String> incorrectAnswers;
  final String correctAnswer;

  factory Question.fromJson(Map<String, dynamic> json) {
    List<String> answers = json['incorrect_answers'];
    String correctAnswer = json['correct_answer'];
    answers.insert(0, correctAnswer);

    return Question(
      index: json.length,
      question: json['question'],
      correctAnswer: json['correct_answer'],
      answers: answers,
    );
  }
}
