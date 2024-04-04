class Question {
  final String question;
  final String correctAnswer;
  final List<dynamic> incorrectAnswers;
  List<String> answers;

  Question({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.answers,
  });

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList as List<String>;
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    List<String> tempAnswers = [];
    List allAnswers = List.of(json['incorrect_answers']);

    allAnswers.insert(0, json['correct_answer']);

    for (var answer in allAnswers) {
      tempAnswers.add(answer);
    }

    // return questionPool;
    return Question(
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: json['incorrect_answers'],
      answers: tempAnswers,
    );
  }
}
