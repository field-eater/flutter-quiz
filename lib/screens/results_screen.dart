import 'package:adv_basics/models/question.dart';
import 'package:adv_basics/providers/question_provider.dart';
import 'package:adv_basics/providers/quiz_provider.dart';
import 'package:adv_basics/widgets/questions_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.restartQuiz,
    required this.questions,
  });

  final List<String> chosenAnswers;
  final void Function() restartQuiz;
  late Future<List<Question>> questions;
  // final List<Question> questionData;

  @override
  Widget build(BuildContext context) {
    List questionsData;
    int numTotalQuestions = 0;
    final List<Map<String, Object>> summary = [];
    var unescape = HtmlUnescape();

    final restartQuiz = Provider.of<QuizProvider>(context).restartQuiz;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: FutureBuilder<List<Question>>(
          future: questions,
          builder: (context, question) {
            if (question.hasData) {
              questionsData = question.data!;
              numTotalQuestions = questionsData.length;

              for (var i = 0; i < numTotalQuestions; i++) {
                summary.add({
                  'question_index': i,
                  'question': unescape.convert(questionsData[i].question),
                  'correct_answer': questionsData[i].correctAnswer,
                  'user_answer': chosenAnswers[i],
                });
              }

              final numCorrectQuestions = summary.where((question) {
                return question['user_answer'] == question['correct_answer'];
              }).length;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
                    // '$questionData',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  QuestionsSummary(summaryData: summary),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(
                      Icons.refresh,
                    ),
                    onPressed: restartQuiz,
                    label: const Text(
                      'Restart Quiz!',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                widthFactor: double.minPositive,
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
