import 'package:flutter/cupertino.dart';

import '../model/Lecture.dart';
import '../model/Exam.dart';
import '../model/Correlation.dart';
import '../model/Question.dart';
import '../model/Topic.dart';
import '../service/SqliteService.dart';

class SqliteServiceController {
  SqliteService service = SqliteService();

  Future<Lecture> insertLecture(String name) async {
    var lectureId = await service.insertLecture(Lecture(name: name));
    return Lecture(id: lectureId, name: name);
  }

  Future<void> removeLecture(int id) async {
    await service.deleteLecture(id);
  }

  void insertExam(String date) {
    service.insertExam(Exam(date: date, passed: false));
  }

  void insertTopic(String title) {
    service.insertTopic(Topic(title: title));
  }

  Future<List<Lecture>> getAllLectures() {
    return service.lectures();
  }
}
