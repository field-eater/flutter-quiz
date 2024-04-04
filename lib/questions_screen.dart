import 'package:adv_basics/answer_button.dart';
import 'package:adv_basics/models/question.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/data/questions_data.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({required this.onSelectAnswer, super.key});

  final void Function(String answer) onSelectAnswer;

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  List futureQuestions = [];
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    // return Text('');
    // final currentQuestion = questionsData[currentQuestionIndex];
    // print(futureQuestions);

    final currentQuestion = futureQuestions[currentQuestionIndex];

    return Scaffold(
      body: Center(
        child: futureQuestions.isNotEmpty
            ? Text(currentQuestion.question)
            : CircularProgressIndicator(),
      ),
    );
  }

  _init() async {
    futureQuestions = await fetchQuestion();

    setState(() {});

    futureQuestions.forEach((element) async {
      element.question;
    });
  }
}
