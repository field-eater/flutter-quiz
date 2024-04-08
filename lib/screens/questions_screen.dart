import 'package:adv_basics/models/question.dart';
import 'package:adv_basics/providers/question_provider.dart';
import 'package:adv_basics/services/question_service.dart';
import 'package:adv_basics/widgets/answer_button.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QuestionsScreen extends StatefulWidget {
  QuestionsScreen(
      {super.key, required this.onSelectAnswer, required this.questions});

  final void Function(String answer) onSelectAnswer;
  late Future<List<Question>> questions;

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  // _init() {
  //   // var res = await fetchQuestions();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: Container(
                margin: const EdgeInsets.all(40),
                child: FutureBuilder<List<Question>>(
                    future: widget.questions,
                    builder: (context, question) {
                      if (question.hasData) {
                        var currentQuestion =
                            question.data![currentQuestionIndex];

                        final answers = context
                            .watch<QuestionProvider>()
                            .getAnswers(currentQuestion.incorrectAnswers,
                                currentQuestion.correctAnswer);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentQuestion.question,
                              style: GoogleFonts.lato(
                                color: const Color.fromARGB(255, 201, 153, 251),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // ...currentQuestion.answers.map((answer) {
                            //   return AnswerButton(
                            //     answerText: answer,
                            //     onTap: () {
                            //       answerQuestion(answer);
                            //     },
                            //   );
                            // }),
                            ...answers.map((answer) {
                              return AnswerButton(
                                answerText: answer,
                                onTap: () {
                                  answerQuestion(answer);
                                },
                              );
                            }),
                          ],
                        );
                      } else if (question.hasError) {
                        return Text('${question.error}');
                      } else {
                        return Center(
                          widthFactor: double.minPositive,
                          child: const CircularProgressIndicator(),
                        );
                      }
                    })),
          ),
        ),
      ),
    );
  }
}
