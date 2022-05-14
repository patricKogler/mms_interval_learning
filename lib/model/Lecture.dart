import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Lecture class contains basic information for lectures
/// [id] is an unique specifier for each lecture in the database
/// [name] is the user generated name for the lecture
class Lecture {
  final int id;
  String name;

  Lecture(this.id, this.name);

}