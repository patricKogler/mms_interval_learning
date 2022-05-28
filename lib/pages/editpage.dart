import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mms_interval_learning/controller/SqliteServiceController.dart';
import 'package:mms_interval_learning/model/Lecture.dart';
import 'package:mms_interval_learning/providers/lectures_provider.dart';
import '../service/SqliteService.dart';
import '../controller/SqliteServiceController.dart';

class EditPage extends ConsumerStatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends ConsumerState<EditPage> {
  SqliteServiceController serviceController = SqliteServiceController();

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(lecturesProvider);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (watch.hasValue)
                for (final v in watch.value ?? []) Text(v.toString()),
              Text('hallo'),
              ElevatedButton(
                onPressed: () {
                  print('HI');
                },
                child: Text('Add new Lecture'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: "add Lecture",
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Add Lecture"),
                    content: Container(
                      child: TextFormField(
                        controller: myController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter the lecture name',
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Dismiss")),
                      TextButton(
                          onPressed: () {
                            ref
                                .read(lecturesProvider.notifier)
                                .addLecture(myController.value.text);
                          },
                          child: Text("Save"))
                    ],
                  );
                });
          }),
    );
  }

  void addNewLecture(name) {
    serviceController.insertLecture(name);
  }

  void addNewExam(date) {
    serviceController.insertExam(date);
  }

  void addNewTopic(title) {
    serviceController.insertTopic(title);
  }
}
