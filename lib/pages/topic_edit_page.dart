import 'package:flutter/material.dart';
import 'package:mms_interval_learning/controller/SqliteServiceController.dart';

import '../model/Topic.dart';

class TopicEditPage extends StatefulWidget {
  final int lectureId;
  Topic? topic;

  TopicEditPage({Key? key, required this.lectureId, this.topic})
      : super(key: key);

  @override
  State<TopicEditPage> createState() => _TopicEditPageState();
}

class _TopicEditPageState extends State<TopicEditPage> {
  final topicNameController = TextEditingController();

  final service = SqliteServiceController();

  Topic? topic = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topic = widget.topic;
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

  @override
  Widget build(BuildContext context) {
    if (topic == null) {
      Future.delayed(Duration.zero, () => _showDialog(context));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: topic == null
          ? Text("")
          : Center(child: Text(topic!.title)),
    );
  }
}
