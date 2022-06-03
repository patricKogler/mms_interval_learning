import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mms_interval_learning/model/Question.dart';

//für lernmodus

class QuestionView extends StatelessWidget {
  final Question question;
  final Function(double) onLearned;

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
                  onPressed: () => onLearned(4.0),
                  child: Text("Again", style: TextStyle(color: Colors.white))),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent)),
                  onPressed: () => onLearned(3.0),
                  child: Text("Hard", style: TextStyle(color: Colors.white))),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellowAccent)),
                  onPressed: () => onLearned(2.0),
                  child: Text("Medium", style: TextStyle(color: Colors.black))),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () => onLearned(1.0),
                  child: Text("Easy", style: TextStyle(color: Colors.black))),
            ],
          )
        ]),
      ),
    );
  }
}
