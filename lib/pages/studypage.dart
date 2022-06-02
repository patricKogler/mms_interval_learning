import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mms_interval_learning/pages/topics_learn_page.dart';
import 'package:mms_interval_learning/providers/exam_provider.dart';
import 'package:mms_interval_learning/service/SqliteService.dart';
import 'package:mms_interval_learning/widgets/exam_accordion.dart';

import '../model/Exam.dart';

class StudyPage extends ConsumerStatefulWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _StudyPage();
  }
}

class _StudyPage extends ConsumerState<StudyPage> {
  Set<int> selectedTopics = {};

  @override
  Widget build(BuildContext context) {
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
                  ExamAccordion(
                      key: Key(v.id.toString()),
                      exam: v,
                      onSelect: (selected, tId) {
                        setState(() {
                          if (selected) {
                            selectedTopics = {...selectedTopics, tId};
                          } else {
                            selectedTopics = {
                              for (final t in selectedTopics)
                                if (t != tId) t
                            };
                          }
                        });
                      }),
              TextButton(
                  onPressed: () {
                    print(selectedTopics);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TopicsLearnPage(
                                  topicIds: selectedTopics,
                                )));
                  },
                  child: const Text("Learn"))
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
