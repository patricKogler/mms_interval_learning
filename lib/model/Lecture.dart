import 'package:flutter/foundation.dart';
import 'package:mms_interval_learning/model/Topic.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Lecture class contains basic information on lectures
/// [id] is an unique specifier for each lecture in the database
/// [name] is the user generated name for the lecture
@immutable
class Lecture {
  final int? id;
  final String name;

  const Lecture({this.id, required this.name});

  /// retrieves data from database in form of a map
  Lecture.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"];

  /// returns map to use in database for inserts
  /// must contain column names as Strings
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name};
  }

  @override
  String toString() {
    return "{[id: $id; name: $name]}";
  }
}
