import 'package:mms_interval_learning/model/Progress.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/Lecture.dart';
import '../model/Exam.dart';
import '../model/Correlation.dart';
import '../model/Question.dart';
import '../model/Topic.dart';


/// Class for all things related to database operations
/// [dbName] contains the name of the database
class SqliteService {
  String dbName = "AppDB.db";

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, dbName),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Lecture(id INTEGER PRIMARY KEY, name TEXT NOT NULL); \n" +
          "CREATE TABLE Exam(id INTEGER PRIMARY KEY, date DATE NOT NULL, passed BOOLEAN); \n" +
          "CREATE TABLE Topic(id INTEGER PRIMARY KEY, title TEXT NOT NULL); \n" +
          "CREATE TABLE Correlation(Lectures.id INTEGER NOT NULL, Exam.id INTEGER NOT NULL, Topic.id NOT NULL, PRIMARY KEY(lectures.id, Exam.id, Topics.id); \n" +
          "CREATE TABLE Question(id INTEGER PRIMARY KEY, media VARCHAR(12), Topic.Id INTEGER NOT NULL); \n" +
          "CREATE TABLE Progress(id INTEGER PRIMARY KEY, evaluation DOUBLE NOT NULL, date DATE NOT NULL, Question.id INTEGER NOT NULL);"
        );
      },
      version: 1,
    );
  }

  Future<void> insertLecture(Lecture lecture) async {
    final Database db = await initializeDB();
    await db.insert("Lecture", lecture.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<void> insertExam(Exam exam) async {
    final Database db = await initializeDB();
    await db.insert("Exam", exam.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<void> insertTopic(Topic topic) async {
    final Database db = await initializeDB();
    await db.insert("Topic", topic.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<void> insertCorrelation(Correlation correlation) async {
    final Database db = await initializeDB();
    await db.insert("Correlation", correlation.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<void> insertQuestion(Question question) async {
    final Database db = await initializeDB();
    await db.insert("Question", question.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<void> insertProgress(Progress progress) async {
    final Database db = await initializeDB();
    await db.insert("Progress", progress.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }



  Future<List<Lecture>> lectures() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> lectures = await db.query("Lecture");
    return List.generate(lectures.length, (i) {
      return Lecture(id: lectures[i]["id"], name: lectures[i]["name"]);
    });
  }

  Future<List<Exam>> exams() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> exams = await db.query("Exam");
    return List.generate(exams.length, (i) {
      return Exam(id: exams[i]["id"], date: exams[i]["date"], passed: exams[i]["passed"]);
    });
  }

  Future<List<Topic>> topics() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> topics = await db.query("Topic");
    return List.generate(topics.length, (i) {
      return Topic(id: topics[i]["id"], title: topics[i]["title"]);
    });
  }

  Future<List<Correlation>> correlations() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> correlations = await db.query("Correlation");
    return List.generate(correlations.length, (i) {
      return Correlation(correlations[i]["Lecture.id"], correlations[i]["Exam.id"], correlations[i]["Topic.id"]);
    });
  }

  Future<List<Question>> questions() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> questions = await db.query("Question");
    return List.generate(questions.length, (i) {
      return Question(id: questions[i]["id"], text: questions[i]["text"], mediaPath: questions[i]["media"], topicId: questions[i]["Topic.id"]);
    });
  }

  Future<List<Progress>> progress() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> progress = await db.query("Progress");
    return List.generate(progress.length, (i) {
      return Progress(id: progress[i]["id"], evaluation: progress[i]["Evaluation"], date: progress[i]["date"], questionId: progress[i]["Question.id"]);
    });
  }
}