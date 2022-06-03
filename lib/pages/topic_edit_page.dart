import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mms_interval_learning/controller/SqliteServiceController.dart';
import 'package:mms_interval_learning/providers/question_provider.dart';
import 'package:mms_interval_learning/widgets/question_editor.dart';

import '../model/Question.dart';
import '../model/Topic.dart';

class TopicEditPage extends ConsumerStatefulWidget {
  final int lectureId;
  final textController = TextEditingController();
  Topic? topic;

  TopicEditPage({Key? key, required this.lectureId, this.topic})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopicEditPageState();
}

class _TopicEditPageState extends ConsumerState<TopicEditPage> {
  final topicNameController = TextEditingController();

  final service = SqliteServiceController();

  Topic? topic = null;

  @override
  void initState() {
    super.initState();
    topic = widget.topic;
    if (topic != null && topic?.id != null) {
      ref.read(questionProvider.notifier).setQuestionsForTopic(topic!.id!);
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Topic"),
            content: TextFormField(
              controller: topicNameController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter the Topic name',
              ),
            ),
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    var t = await service.insertTopic(
                        topicNameController.value.text, widget.lectureId);
                    setState(() {
                      topic = t;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text("Save"))
            ],
          );
        });
  }

  void addQuestion() {
    ref.read(questionProvider.notifier).addQuestion("", topic!.id!);
  }

  @override
  Widget build(BuildContext context) {
    if (topic == null) {
      Future.delayed(Duration.zero, () => _showDialog(context));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(topic?.title ?? ""),
      ),
      body: topic == null
          ? Text("")
          : Column(
              children: [
                Row(children: [
                  Text(topic!.title),
                  TextButton(onPressed: addQuestion, child: Icon(Icons.add))
                ]),
                for (final Question question in ref.watch(questionProvider))
                  QuestionEditor(
                    key: Key(question.id.toString()),
                    onChanged: (str) {
                      ref
                          .read(questionProvider.notifier)
                          .updateQuestion(question.copyWith(text: str));
                    },
                    question: question,
                  ),
              ],
            ),
    );
  }

  void testfunction() {
    print('Test');
  }
}
