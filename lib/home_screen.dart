import 'package:adv_basics/models/question.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var logoPath = 'assets/images/quiz-logo.png';

class HomeScreen extends StatelessWidget {
  HomeScreen(this.startQuiz, {super.key});
  late Future<Question> futureQuestions;
  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          logoPath,
          color: const Color.fromARGB(150, 255, 255, 255),
          width: 300,
        ),
        const SizedBox(
          height: 80,
        ),
        Text(
          'Learn Flutter the fun way!',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        OutlinedButton.icon(
          onPressed: startQuiz,
          icon: const Icon(Icons.arrow_right_alt),
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.black26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
          label: const Text('Start Quiz'),
        )
      ]),
    );
  }
}
