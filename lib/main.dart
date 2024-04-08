import 'package:adv_basics/providers/question_provider.dart';
import 'package:adv_basics/providers/quiz_provider.dart';
import 'package:adv_basics/quiz.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuizProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => QuestionProvider(),
        ),
      ],
      child: const Quiz(),
    );
  }
}
