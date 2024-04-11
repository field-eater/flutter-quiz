import 'package:adv_basics/data/questions_data.dart';
import 'package:adv_basics/questions_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen(
      {super.key,
      required this.chosenAnswers,
      required this.restartQuiz,
      required this.questions});
  List questions;
  final List<String> chosenAnswers;
  final void Function() restartQuiz;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    var unescape = HtmlUnescape();

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': unescape.convert(questions[i].question),
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;

    final numCorrectQuestions = summaryData.where((question) {
      return question['user_answer'] == question['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
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
            QuestionsSummary(summaryData: summaryData),
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
        ),
      ),
    );
  }
}
