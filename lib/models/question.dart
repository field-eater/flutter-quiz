class Question {
  final String question;
  final String correctAnswer;
  final List<dynamic> incorrectAnswers;
  final List<String> answers;

  Question({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.answers,
  });

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    List<String> tempAnswers = [];

    // List<Question> questionPool = [];
    // json.forEach((el) {
    //   questionPool.add(Question(
    //       question: el['question'],
    //       correctAnswer: el['correct_answer'],
    //       incorrectAnswers: el['incorrect_answers'],
    //       answers: []));
    // });

    // // json.forEach((answer) => tempAnswers.add(answer));
    // // tempAnswers = List.from(json);
    // return questionPool;
    return Question(
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: json['incorrect_answers'],
      answers: tempAnswers,
    );
  }
}
