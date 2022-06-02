import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mms_interval_learning/model/Question.dart';

//für lernmodus

class QuestionView extends StatelessWidget {
  final Question question;
  final VoidCallback onLearned;

  const QuestionView(
      {Key? key, required this.question, required this.onLearned})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          Expanded(child: Markdown(data: question.text)),
          TextButton(onPressed: onLearned, child: Text("Learned"))
        ]),
      ),
    );
  }
}
