import 'dart:async';

import 'package:mms_interval_learning/model/Progress.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/Exam.dart';
import '../model/Lecture.dart';
import '../model/Question.dart';
import '../model/Topic.dart';

/// Class for all things related to database operations
/// [dbName] contains the name of the database
class SqliteService {
  String dbName = "AppDB.db";

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    print(path);

    return openDatabase(
      join(path, dbName),
      onCreate: (database, version) async {
        await database.execute("CREATE TABLE Lecture(id INTEGER PRIMARY KEY, name TEXT NOT NULL); " +
            "CREATE TABLE Exam(id INTEGER PRIMARY KEY, lecture_id INTEGER NOT NULL, date DATE NOT NULL, passed BOOLEAN); " +
            "CREATE TABLE Topic(id INTEGER PRIMARY KEY, title TEXT NOT NULL); " +
            "CREATE TABLE TopicExam(exam_id INTEGER NOT NULL, topic_id INTEGER NOT NULL, PRIMARY KEY(exam_id, topic_id));" +
            "CREATE TABLE Question(id INTEGER PRIMARY KEY, text VARCHAR(254), media VARCHAR(12), topic_id INTEGER NOT NULL); " +
            "CREATE TABLE Progress(id INTEGER PRIMARY KEY, evaluation DOUBLE NOT NULL, date DATE NOT NULL, question_id INTEGER NOT NULL);");
      },
      version: 1,
    );
  }

  /// insert tuple [lecture] into table Lecture
  Future<int> insertLecture(Lecture lecture) async {
    final Database db = await initializeDB();
    var id = await db.insert("Lecture", lecture.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  /// insert tuple [exam] into table Exam
  Future<int> insertExam(Exam exam) async {
    final Database db = await initializeDB();
    return await db.insert("Exam", exam.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Exam> getDefaultExamForLecture(int lectureId) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> exams =
        await db.query("Exam", where: "lecture_id = ?", whereArgs: [lectureId]);
    return Exam.fromMap(exams.first);
  }

  Future<void> linkExamAndTopic(int examId, int topicId) async {
    final Database db = await initializeDB();
    await db.insert("TopicExam", {"exam_id": examId, "topic_id": topicId});
  }

  /// insert tuple [topic] into table Topic
  Future<int> insertTopic(Topic topic) async {
    final Database db = await initializeDB();
    return await db.insert("Topic", topic.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// insert tuple [question] into table Question
  Future<int> insertQuestion(Question question) async {
    final Database db = await initializeDB();
    return await db.insert("Question", question.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// insert tuple [progress] into table Progress
  Future<void> insertProgress(Progress progress) async {
    final Database db = await initializeDB();
    await db.insert("Progress", progress.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// return table Lecture as list
  Future<List<Lecture>> lectures() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> lectures = await db.query("Lecture");
    return List.generate(lectures.length, (i) {
      return Lecture.fromMap(lectures[i]);
    });
  }

  Future<List<Topic>> getTopicsForLecture(int lectureId) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> topics = await db.rawQuery(
        "SELECT * FROM Topic t WHERE t.id IN(SELECT te.topic_id FROM TopicExam te JOIN Exam e ON e.id = te.exam_id WHERE e.lecture_id = ?)",
        [lectureId]);
    return List.generate(topics.length, (i) {
      return Topic.fromMap(topics[i]);
    });
  }

  /// return table Exam as list
  Future<List<Exam>> exams() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> exams = await db.query("Exam");
    return List.generate(exams.length, (i) {
      return Exam.fromMap(exams[i]);
    });
  }

  Future<List<Topic>> getTopicsForExam(int examId) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> topics = await db.rawQuery(
        "SELECT * FROM Topic t WHERE t.id IN(SELECT te.topic_id FROM TopicExam te WHERE te.exam_id = ?)",
        [examId]);
    return List.generate(topics.length, (i) {
      return Topic.fromMap(topics[i]);
    });
  }

  /// return table Topic as list
  Future<List<Topic>> topics() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> topics = await db.query("Topic");
    return List.generate(topics.length, (i) {
      return Topic.fromMap(topics[i]);
    });
  }

  /// return table Question as list
  Future<List<Question>> questions() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> questions = await db.query("Question");
    return List.generate(questions.length, (i) {
      return Question.fromMap(questions[i]);
    });
  }

  /// return table Progress as list
  Future<List<Progress>> progress() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> progress = await db.query("Progress");
    return List.generate(progress.length, (i) {
      return Progress.fromMap(progress[i]);
    });
  }

  /// updates Lecture table in database
  /// new values are passed through [lecture] parameter
  Future<void> updateLecture(Lecture lecture) async {
    final Database db = await initializeDB();
    await db.update("Lecture", lecture.toMap(),
        where: "id", whereArgs: [lecture.id]);
  }

  /// updates Exam table in database
  /// new values are passed through [exam] parameter
  Future<void> updateExam(Exam exam) async {
    final Database db = await initializeDB();
    await db
        .update("Exam", exam.toMap(), where: "id = ?", whereArgs: [exam.id]);
  }

  /// updates Topic table in database
  /// new values are passed through [topic] parameter
  Future<void> updateTopic(Topic topic) async {
    final Database db = await initializeDB();
    await db
        .update("Topic", topic.toMap(), where: "id = ?", whereArgs: [topic.id]);
  }

  /// updates Question table in database
  /// new values are passed through [question] parameter
  Future<void> updateQuestion(Question question) async {
    final Database db = await initializeDB();
    await db.update("Question", question.toMap(),
        where: "id = ?", whereArgs: [question.id]);
  }

  /// updates Progress table in database
  /// new values are passed through [progress] parameter
  Future<void> updateProgress(Progress progress) async {
    final Database db = await initializeDB();
    await db.update("Progress", progress.toMap(),
        where: "id = ?", whereArgs: [progress.id]);
  }

  /// deletes row of Lecture Table
  /// [id] passes id of row to delete
  Future<void> deleteLecture(int id) async {
    final Database db = await initializeDB();
    await db.delete("Lecture", where: "id = ?", whereArgs: [id]);
  }

  /// deletes row of Exam Table
  /// [id] passes id of row to delete
  Future<void> deleteExam(int id) async {
    final Database db = await initializeDB();
    await db.delete("Exam", where: "id = ?", whereArgs: [id]);
  }

  /// deletes row of Topic Table
  /// [id] passes id of row to delete
  Future<void> deleteTopic(int id) async {
    final Database db = await initializeDB();
    await db.delete("Topics", where: "id = ?", whereArgs: [id]);
  }

  /// deletes row of Question Table
  /// [id] passes id of row to delete
  Future<void> deleteQuestion(int id) async {
    final Database db = await initializeDB();
    await db.delete("Question", where: "id = ?", whereArgs: [id]);
  }

  /// deletes row of Progress Table
  /// [id] passes id of row to delete
  Future<void> deleteProgress(int id) async {
    final Database db = await initializeDB();
    await db.delete("Progress", where: "id = ?", whereArgs: [id]);
  }
}
