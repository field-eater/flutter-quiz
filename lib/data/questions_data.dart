import 'dart:convert';
import 'package:adv_basics/models/question.dart';
import 'package:http/http.dart' as http;

Future<List<Question>> fetchQuestion() async {
  final response = await http.get(Uri.parse(
      'https://opentdb.com/api.php?amount=10&category=20&difficulty=easy&type=multiple'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,

    final jsonRes = jsonDecode(response.body)['results'];

    List<Question> questionsResult = [];

    // jsonRes.forEach((el) {
    //   questionsResult.add(Question.fromJson(el));
    //   // print(el);
    // });

    for (var el in jsonRes) {
      questionsResult.add(Question.fromJson(el));
    }

    // then parse the JSON.
    return questionsResult;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load question');
  }
}

var questionsData = fetchQuestion();
