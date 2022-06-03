import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mms_interval_learning/controller/SqliteServiceController.dart';
import 'package:mms_interval_learning/model/Lecture.dart';
import 'package:mms_interval_learning/providers/exam_provider.dart';
import 'package:mms_interval_learning/providers/lectures_provider.dart';
import 'package:mms_interval_learning/widgets/lecture_accordion.dart';

import '../controller/SqliteServiceController.dart';

class EditPage extends ConsumerStatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends ConsumerState<EditPage> {
  SqliteServiceController serviceController = SqliteServiceController();

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
                for (final Lecture v in watch.value ?? [])
                  LectureAccordion(key: Key(v.id.toString()), lecture: v),
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
                  return AddLectureDialog(ref: ref);
                });
          }),
    );
  }
}

class AddLectureDialog extends StatefulWidget {
  const AddLectureDialog({
    Key? key,
    required this.ref,
  }) : super(key: key);

  final WidgetRef ref;

  @override
  State<AddLectureDialog> createState() => _AddLectureDialogState();
}

class _AddLectureDialogState extends State<AddLectureDialog> {
  final lectureTextController = TextEditingController();
  final examDateController = TextEditingController();
  DateTime? _selectedDate = null;
  bool isNextDisabled = true;
  bool isSaveDisabled = true;
  Widget? _step = null;
  bool _lastStep = false;

  @override
  void initState() {
    super.initState();
    _step = TextFormField(
      controller: lectureTextController,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Enter the lecture name',
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    lectureTextController.dispose();
    examDateController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));
    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      examDateController
        ..text = DateFormat.yMMMd().format(newSelectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: examDateController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  void setNext() {
    setState(() {
      _lastStep = true;
      _step = TextFormField(
        onTap: () {
          _selectDate(context);
        },
        controller: examDateController,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Enter Date of First Exam',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    lectureTextController.addListener(() {
      setState(() {
        isNextDisabled = lectureTextController.value.text.isEmpty;
      });
    });

    examDateController.addListener(() {
      setState(() {
        isSaveDisabled = examDateController.value.text.isEmpty;
      });
    });

    return AlertDialog(
      title: Text("Add Lecture"),
      content: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _step,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Dismiss")),
        if (!_lastStep)
          OutlinedButton(
              onPressed: isNextDisabled ? null : setNext, child: Text("Next")),
        if (_lastStep)
          OutlinedButton(
              onPressed: isSaveDisabled
                  ? null
                  : () async {
                      var lectureId = await widget.ref
                          .read(lecturesProvider.notifier)
                          .addLecture(lectureTextController.value.text);
                      widget.ref
                          .read(examProvider.notifier)
                          .addExam(lectureId!, examDateController.value.text);
                      lectureTextController.clear();
                      Navigator.of(context).pop();
                    },
              child: Text("Save")),
      ],
    );
  }
}
