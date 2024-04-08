import 'package:adv_basics/models/question.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String api = dotenv.env['API_URL'] as String;

Future<List<Question>> fetchQuestions() async {
  final response = await http.get(Uri.parse(api));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final request = json.decode(response.body)['results'];
    List<Question> questions = [];

    request.forEach((element) => questions.add(Question.fromJson(element)));

    return questions;
  } else {
    throw Exception('Failed to load question');
  }
}
