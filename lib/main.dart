import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:quiz_app_mobile/models/quiz.dart';
import 'package:quiz_app_mobile/quiz/create_view.dart';
import 'package:quiz_app_mobile/quiz/list.dart';
import 'package:quiz_app_mobile/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Software Sanctuary',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelStyle: TextStyle(color: Colors.black, fontSize: 24.0),
          focusColor: Colors.black
        ),
      ),
      home: const MyHomePage(title: 'Software Sanctuary'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService api = ApiService();
  List<Quiz> quizList = <Quiz>[];
  late Future quizFuture;

  @override
  void initState() {
    super.initState();

    // Assign that variable your Future.
    quizFuture = loadQuizList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: Center(
        child: FutureBuilder(
          future: quizFuture,
          builder: (context, snapshot) {
            return quizList.isNotEmpty
                ? QuizList(quiz: quizList)
                : Center(
                    child: Text('No Quiz found!',
                        style: Theme.of(context).textTheme.headline6));
          },
        ),
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => loadQuizList(),
            child: Icon(Icons.refresh),
          ),
          FloatingActionButton(
            onPressed: () => _navigateToNextScreen(context),
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }

  Future loadQuizList() {
    Future<List<Quiz>> futureQuiz = api.getQuizList();
    futureQuiz.then((quizList) {
      setState(() {
        this.quizList = quizList;
      });
    });
    return futureQuiz;
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreateQuizView()));
  }
}
