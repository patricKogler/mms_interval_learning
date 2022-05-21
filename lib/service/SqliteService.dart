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


  /// insert tuple [lecture] into table Lecture
  Future<void> insertLecture(Lecture lecture) async {
    final Database db = await initializeDB();
    await db.insert("Lecture", lecture.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// insert tuple [exam] into table Exam
  Future<void> insertExam(Exam exam) async {
    final Database db = await initializeDB();
    await db.insert("Exam", exam.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// insert tuple [topic] into table Topic
  Future<void> insertTopic(Topic topic) async {
    final Database db = await initializeDB();
    await db.insert("Topic", topic.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// insert tuple [correlation] into table Correlation
  Future<void> insertCorrelation(Correlation correlation) async {
    final Database db = await initializeDB();
    await db.insert("Correlation", correlation.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// insert tuple [question] into table Question
  Future<void> insertQuestion(Question question) async {
    final Database db = await initializeDB();
    await db.insert("Question", question.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// insert tuple [progress] into table Progress
  Future<void> insertProgress(Progress progress) async {
    final Database db = await initializeDB();
    await db.insert("Progress", progress.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }


  /// return table Lecture as list
  Future<List<Lecture>> lectures() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> lectures = await db.query("Lecture");
    return List.generate(lectures.length, (i) {
      return Lecture.fromMap(lectures[i]);
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

  /// return table Topic as list
  Future<List<Topic>> topics() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> topics = await db.query("Topic");
    return List.generate(topics.length, (i) {
      return Topic.fromMap(topics[i]);
    });
  }

  /// return table Correlation as list
  Future<List<Correlation>> correlations() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> correlations = await db.query("Correlation");
    return List.generate(correlations.length, (i) {
      return Correlation.fromMap(correlations[i]);
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
}