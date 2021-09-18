import 'package:flutter/material.dart';
import 'package:quiz_app_mobile/models/quiz.dart';

class QuizList extends StatelessWidget {

  final List<Quiz> quiz;
  QuizList({required this.quiz}) : super();

  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
          itemCount: quiz == null ? 0 : quiz.length,
          itemBuilder: (BuildContext context, int index) {
            return
              Card(
                  child: InkWell(
                    onTap: () {

                    },
                    child: ListTile(
                      leading: Icon(Icons.question_answer),
                      title: Text(quiz[index].name),
                      subtitle: Text(quiz[index].category.toString()),
                    ),
                  )
              );
          });
  }

}