import 'package:dio/dio.dart';

import '../models/question_api.dart';

Future<List<QuestionApi>> getQuestions(
    String categories, String limit, String difficulty) async {
  final url = 'https://the-trivia-api.com/api/questions?' +
      (categories.isNotEmpty ? 'categories=' + categories + '&' : '') +
      'limit=' +
      limit +
      '&difficulty=' +
      difficulty;
  final response = await Dio().get(url);
  if (response.statusCode == 200) {
    List listJson = (response.data as List);
    return listJson.map((json) => QuestionApi.fromJson(json)).toList();
  }
  return Future.value([]);
}
