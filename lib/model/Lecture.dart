import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Lecture class contains basic information for lectures
/// [id] is an unique specifier for each lecture in the database
/// [name] is the user generated name for the lecture
class Lecture {
  final int? id;
  String name;

  Lecture({this.id, required this.name});

  /// retrieves Data from database in form of a map
  Lecture.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      name = map["name"];


  /// returns map for database
  /// must contain column names as Strings
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name
    };
  }
}
