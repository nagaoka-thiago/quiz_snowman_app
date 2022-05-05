import 'package:dio/dio.dart';

import '../models/question_api.dart';

Future<List<QuestionApi>> testandoApi() async {
  Response response = await Dio().get(
      'https://the-trivia-api.com/api/questions?categories=arts_and_literature,film_and_tv,food_and_drink&limit=8&difficulty=easy');
  if (response.statusCode == 200) {
    List listJson = (response.data as List);
    return listJson.map((json) => QuestionApi.fromJson(json)).toList();
  }
  return Future.value([]);
}
/*return FutureBuilder(
        future: testandoApi(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<QuestionApi> listQuestions =
                snapshot.data as List<QuestionApi>;
            return ListView.builder(
                itemCount: listQuestions.length,
                itemBuilder: (context, i) {
                  return Text(
                      listQuestions[i].incorrectAnswers!.length.toString());
                });
          }
          return Text('Deu erro!');
        });*/