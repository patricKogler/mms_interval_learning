import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

//für lernmodus

class QuestionView extends StatelessWidget {
  final String data;

  QuestionView({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Markdown(data: data),
      ),
    );
  }
}