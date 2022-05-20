

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
          "CREATE TABLE Topics(id INTEGER PRIMARY KEY, title TEXT NOT NULL); \n" +
          "CREATE TABLE Correlation(Lectures.id INTEGER NOT NULL, Exam.id INTEGER NOT NULL, Topic.id NOT NULL, PRIMARY KEY(lectures.id, Exam.id, Topics.id); \n" +
          "CREATE TABLE Questions(id INTEGER PRIMARY KEY, media VARCHAR(12) NOT NULL, Topic.Id INTEGER NOT NULL); \n" +
          "CREATE TABLE Progress(id INTEGER PRIMARY KEY, evaluation DOUBLE NOT NULL, date DATE NOT NULL, Question.id INTEGER NOT NULL);"
        );
      },
      version: 1,
    );
  }
}

