import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mms_interval_learning/providers/selected_topic_provider.dart';

import '../model/Exam.dart';
import '../model/Topic.dart';
import '../service/SqliteService.dart';

class ExamAccordion extends ConsumerStatefulWidget {
  final Exam exam;

  const ExamAccordion({Key? key, required this.exam}) : super(key: key);

  @override
  _ExamAccordionState createState() => _ExamAccordionState();
}

class _ExamAccordionState extends ConsumerState<ExamAccordion> {
  bool showTopics = false;
  AsyncValue<List<Topic>> topics = AsyncValue.loading();
  SqliteService sqliteService = SqliteService();

  void toggleTopics() async {
    setState(() {
      showTopics = !showTopics;
    });
    if (showTopics) {
      var t = await AsyncValue.guard(
          () => sqliteService.getTopicsForExam(widget.exam.id!));
      setState(() {
        topics = t;
      });
    }
  }

  toggleSelectedTopic(Topic topic) {
    ref.read(selectedTopicsProvider.notifier).toggleSelectedTopic(topic);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 400,
                  height: 40,
                  child: OutlinedButton(
                      onPressed: toggleTopics,
                      child: Row(
                        children: [
                          Expanded(child: Text(widget.exam.date)),
                          if (showTopics)
                            const Icon(Icons.arrow_drop_down)
                          else
                            const Icon(Icons.arrow_left)
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SizedBox(
                      height: 40,
                      child: OutlinedButton(
                          onPressed: () {}, child: const Icon(Icons.add))),
                )
              ]),
          if (showTopics)
            Padding(
              padding: const EdgeInsets.only(right: 40, top: 1),
              child: Column(
                children: [
                  if (topics.hasValue)
                    for (final Topic topic in topics.value ?? [])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: SizedBox(
                          width: 380,
                          height: 35,
                          child: OutlinedButton(
                              style: ref.watch(selectedTopicsProvider).contains(topic.id!) ? ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue.shade300)) : null,
                              onPressed: () {
                                toggleSelectedTopic(topic);
                              },
                              child: Row(
                                children: [
                                  Expanded(child: Text(topic.title)),
                                ],
                              )),
                        ),
                      )
                ],
              ),
            )
        ],
      ),
    );
  }
}
