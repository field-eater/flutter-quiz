import 'package:adv_basics/models/question.dart';
import 'package:adv_basics/providers/question_provider.dart';
import 'package:adv_basics/providers/quiz_provider.dart';

import 'package:adv_basics/widgets/answer_button.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';

class QuestionsScreen extends StatefulWidget {
  QuestionsScreen({
    super.key,
    required this.answerQuestion,
    required this.questions,
  });

  final void Function(String answer, int qLength) answerQuestion;
  late Future<List<Question>> questions;

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  Map<int, List<String>> answers = {};
  List<Question> finalQuestions = [];
  late int length;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  _init() async {
    finalQuestions = await widget.questions;
    length = finalQuestions.length;
    List<String> finalAnswers = [];
    for (int i = 0; i < finalQuestions.length; i++) {
      finalAnswers = Provider.of<QuestionProvider>(context, listen: false)
          .getAnswers(finalQuestions[i].incorrectAnswers,
              finalQuestions[i].correctAnswer);
      finalAnswers.shuffle();

      answers[i] = finalAnswers;
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestionIndex =
        Provider.of<QuizProvider>(context, listen: false).currentQuestionIndex;
    var unescape = HtmlUnescape();

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
                      final currentQuestion =
                          question.data![currentQuestionIndex];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            unescape.convert(currentQuestion.question),
                            style: GoogleFonts.lato(
                              color: const Color.fromARGB(255, 201, 153, 251),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ...answers[currentQuestionIndex]!.map((answer) {
                            return AnswerButton(
                              answerText: unescape.convert(answer),
                              onTap: () {
                                widget.answerQuestion(answer, length);
                              },
                            );
                          }),
                        ],
                      );
                    } else if (question.hasError) {
                      return Text('${question.error}');
                    } else {
                      return const Center(
                        widthFactor: double.minPositive,
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
