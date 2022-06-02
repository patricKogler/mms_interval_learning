import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mms_interval_learning/model/Lecture.dart';
import 'package:mms_interval_learning/model/Topic.dart';
import 'package:mms_interval_learning/service/SqliteService.dart';

import '../model/Question.dart';

class QuestionEditor extends StatefulWidget {
  final Function(String) onChanged;
  final Question question;

  const QuestionEditor(
      {Key? key, required this.onChanged, required this.question})
      : super(key: key);

  @override
  State<QuestionEditor> createState() => _QuestionEditorState();
}

class _QuestionEditorState extends State<QuestionEditor> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.question.text;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        cursorColor: Colors.cyan[700],
        autofocus: true,
        textInputAction: TextInputAction.next,
        //keyboardType: TextInputType.multiline,
        maxLines: 1,
        onChanged: widget.onChanged,
      ),
    );
  }
}
