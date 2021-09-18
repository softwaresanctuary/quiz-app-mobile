import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_mobile/models/quiz.dart';
import 'package:quiz_app_mobile/services/api_service.dart';

class CreateQuizView extends StatelessWidget {
  final ApiService api = ApiService();
  final _addQuizFormKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Quiz')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _addQuizFormKey,
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                      labelText: "Id",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.tag)),
                  controller: idController,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.label)),
                  controller: nameController,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  decoration: const InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category)),
                  controller: categoryController,
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () => _saveQuiz(context),
                  child: const Text("Save"),
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  void _saveQuiz(BuildContext context) {
    _addQuizFormKey.currentState!.save();
    Quiz quiz = Quiz(id: idController.text, name: nameController.text, status: 1, category: categoryController.text);
    api.createQuiz(quiz);
    Navigator.pop(context);
  }
}
