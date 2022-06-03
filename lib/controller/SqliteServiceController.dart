import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mms_interval_learning/model/Progress.dart';

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

  Future<Question> insertQuestion(String question, int topicId) async {
    var createdAt = DateFormat.yMMMd().format(DateTime.now());
    int questionId = await service.insertQuestion(
        Question(createdAt: createdAt, text: question, topicId: topicId));

    return Question(
        id: questionId, createdAt: createdAt, text: question, topicId: topicId);
  }

  Future<void> updateQuestion(Question question) async {
    await service.updateQuestion(question);
  }

  Future<void> insertProgress(int questionId, double evaluation) async {
    await service.insertProgress(Progress(
        evaluation: evaluation,
        questionId: questionId,
        date: DateFormat.yMMMd().format(DateTime.now())));
  }

  Future<List<Progress>> getProgressForQuestion(int questionId) async {
    var progress = await service.progress();
    return [
      for (final p in progress)
        if (p.questionId == questionId) p
    ]..sort((a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
  }

  Future<Set<Question>> getQuestionsForTopics(Set<int> topicIds) async {
    final questions = await service.questions();
    return {
      for (final question in questions)
        if (topicIds.contains(question.topicId)) question
    };
  }
}
