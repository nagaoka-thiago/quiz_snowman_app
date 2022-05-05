class QuestionApi {
  String? category;
  String? id;
  String? correctAnswer;
  List<String>? incorrectAnswers;
  String? question;
  List<String>? tags;
  String? type;
  String? difficulty;

  QuestionApi(
      {this.category,
      this.id,
      this.correctAnswer,
      this.incorrectAnswers,
      this.question,
      this.tags,
      this.type,
      this.difficulty});

  QuestionApi.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    id = json['id'];
    correctAnswer = json['correctAnswer'];
    incorrectAnswers = json['incorrectAnswers'].cast<String>();
    question = json['question'];
    tags = json['tags'].cast<String>();
    type = json['type'];
    difficulty = json['difficulty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category'] = category;
    data['id'] = id;
    data['correctAnswer'] = correctAnswer;
    data['incorrectAnswers'] = incorrectAnswers;
    data['question'] = question;
    data['tags'] = tags;
    data['type'] = type;
    data['difficulty'] = difficulty;
    return data;
  }
}
