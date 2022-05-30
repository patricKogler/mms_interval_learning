import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mms_interval_learning/providers/exam_provider.dart';
import 'package:mms_interval_learning/service/SqliteService.dart';
import 'package:mms_interval_learning/widgets/exam_accordion.dart';

import '../model/Exam.dart';

class StudyPage extends ConsumerWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(examProvider);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (watch.hasValue)
                for (final Exam v in watch.value ?? [])
                  ExamAccordion(key: Key(v.id.toString()), exam: v),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: "add Exam",
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text("Not Implemented Yet"),
                  );
                });
          }),
    );
  }
}
