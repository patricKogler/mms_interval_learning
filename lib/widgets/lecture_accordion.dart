import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mms_interval_learning/model/Lecture.dart';
import 'package:mms_interval_learning/model/Topic.dart';
import 'package:mms_interval_learning/service/SqliteService.dart';

import '../pages/topic_edit_page.dart';

class LectureAccordion extends StatefulWidget {
  final Lecture lecture;

  const LectureAccordion({Key? key, required this.lecture}) : super(key: key);

  @override
  State<LectureAccordion> createState() => _LectureAccordionState();
}

class _LectureAccordionState extends State<LectureAccordion> {
  bool showTopics = false;
  AsyncValue<List<Topic>> topics = AsyncValue.loading();
  SqliteService sqliteService = SqliteService();

  void toggleTopics() async {
    setState(() {
      showTopics = !showTopics;
    });
    if (showTopics) {
      var t = await AsyncValue.guard(
          () => sqliteService.getTopicsForLecture(widget.lecture.id!));
      setState(() {
        topics = t;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            SizedBox(
              width: 400,
              height: 40,
              child: OutlinedButton(
                  onPressed: toggleTopics,
                  child: Row(
                    children: [
                      Expanded(child: Text(widget.lecture.name)),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TopicEditPage(
                                      lectureId: widget.lecture.id!,
                                    )));
                      },
                      child: const Icon(Icons.add))),
            )
          ]),
          if (showTopics)
            Column(
              children: [
                if (topics.hasValue)
                  for (final Topic topic in topics.value ?? [])
                    SizedBox(
                      width: 380,
                      height: 35,
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopicEditPage(
                                      lectureId: widget.lecture.id!,
                                      topic: topic,
                                    )));
                          },
                          child: Row(
                            children: [
                              Expanded(child: Text(topic.title)),
                            ],
                          )),
                    )
              ],
            )
        ],
      ),
    );
  }
}
