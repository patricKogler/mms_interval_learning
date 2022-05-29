import 'package:flutter/cupertino.dart';

import '../model/Lecture.dart';
import '../model/Exam.dart';
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

  Future<Exam> insertExam(int lectureId, String date) async {
    var examId = await service
        .insertExam(Exam(lectureId: lectureId, date: date, passed: false));
    return Exam(id: examId, lectureId: lectureId, date: date, passed: false);
  }

  Future<void> removeExam(int id) async {
    await service.deleteExam(id);
  }

  Future<Topic> insertTopic(String title, int lectureId) async {
    var topicId = await service.insertTopic(Topic(title: title));
    var defaultExamForLecture =
        await service.getDefaultExamForLecture(lectureId);
    service.linkExamAndTopic(defaultExamForLecture.id!, topicId);
    return Topic(id: topicId, title: title);
  }

  Future<List<Lecture>> getAllLectures() {
    return service.lectures();
  }

  Future<List<Exam>> getAllExams() {
    return service.exams();
  }
}
