import 'dart:convert';

import 'package:quiz_app_mobile/models/quiz.dart';
import 'package:http/http.dart';

class ApiService {
  final String CREATE_QUIZ_URL = "http://localhost:9001/quiz";
  final String LIST_QUIZ_URL = "http://localhost:9001/quiz/list";

  Future<List<Quiz>> getQuizList() async {
    Response res = await get(LIST_QUIZ_URL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Quiz> cases = body.map((dynamic item) => Quiz.fromJson(item)).toList();
      return cases..sort();
    } else {
      throw "Failed to load quiz list";
    }
  }

  Future<Quiz> createQuiz(Quiz quiz) async {
    Map data = {
      'id': quiz.id,
      'name': quiz.name,
      'status': 1,
      'category': quiz.category,
    };

    final Response response = await post(
      CREATE_QUIZ_URL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Quiz.fromJson(json.decode(response.body.toString()));
    } else {
      throw Exception('Failed to post cases');
    }
  }
}