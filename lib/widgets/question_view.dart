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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(child: Markdown(data: question.text)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: onLearned,
                  child: Text("Again", style: TextStyle(color: Colors.white))),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent)),
                  onPressed: onLearned,
                  child: Text("Hard", style: TextStyle(color: Colors.white))),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellowAccent)),
                  onPressed: onLearned,
                  child: Text("Medium", style: TextStyle(color: Colors.black))),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green)),
                  onPressed: onLearned,
                  child: Text("Easy", style: TextStyle(color: Colors.black))),
            ],
          )
        ]),
      ),
    );
  }
}
