import 'package:flutter/material.dart';
import 'package:mms_interval_learning/controller/SqliteServiceController.dart';

import '../model/Topic.dart';

class TopicEditPage extends StatelessWidget {
  final int lectureId;
  Topic? topic;
  final topicNameController = TextEditingController();
  final service = SqliteServiceController();

  TopicEditPage({Key? key, required this.lectureId, this.topic})
      : super(key: key);

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
                  onPressed: () {
                    service.insertTopic(
                        topicNameController.value.text, lectureId);
                    Navigator.of(context).pop();
                  },
                  child: Text("Save"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (topic == null) {
      Future.delayed(Duration.zero, () => _showDialog(context));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: topic == null ? Text("") : Center(child: Text(topic!.title)),
    );
  }
}
