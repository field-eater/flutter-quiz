import 'dart:async';

import 'package:adv_basics/providers/question_provider.dart';

import 'package:adv_basics/models/question.dart';
import 'package:adv_basics/providers/quiz_provider.dart';
import 'package:adv_basics/screens/home_screen.dart';
import 'package:adv_basics/screens/questions_screen.dart';
import 'package:adv_basics/screens/results_screen.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  late Future<List<Question>> futureQuestions;
  int qLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  _init() async {
    futureQuestions =
        Provider.of<QuestionProvider>(context, listen: false).getQuestions();
    // futureQuestions.forEach((element) => element);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 78, 13, 151),
                  Color.fromARGB(255, 107, 15, 168),
                ],
              ),
            ),
            child: Consumer<QuizProvider>(
              builder: (context, quiz, child) {
                if (quiz.activeScreen == 'questions-screen') {
                  return quiz.screenWidget = QuestionsScreen(
                    questions: futureQuestions,
                    answerQuestion: quiz.answerQuestion,
                  );
                }

                if (quiz.activeScreen == 'results-screen') {
                  return quiz.screenWidget = ResultsScreen(
                    questions: futureQuestions,
                    chosenAnswers: quiz.selectedAnswers,
                    restartQuiz: quiz.restartQuiz,
                  );
                }
                return quiz.screenWidget = HomeScreen();
              },
            )),
      ),
    );
  }
}
