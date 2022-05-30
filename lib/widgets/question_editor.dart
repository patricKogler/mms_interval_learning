import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mms_interval_learning/model/Lecture.dart';
import 'package:mms_interval_learning/model/Topic.dart';
import 'package:mms_interval_learning/service/SqliteService.dart';

class QuestionEditor extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final Function(String) onChanged;

  QuestionEditor({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        cursorColor: Colors.cyan[700],
        controller: controller,
        autofocus: true,
        textInputAction: TextInputAction.next,
        //keyboardType: TextInputType.multiline,
        maxLines: 1,
        onChanged: onChanged,
      ),
    );
  }
  
  

}
