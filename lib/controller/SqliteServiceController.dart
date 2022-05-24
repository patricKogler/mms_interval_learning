import 'package:flutter/cupertino.dart';

import '../model/Lecture.dart';
import '../model/Exam.dart';
import '../model/Correlation.dart';
import '../model/Question.dart';
import '../model/Topic.dart';
import '../service/SqliteService.dart';

class SqliteServiceController {

  SqliteService service = SqliteService();

  void insertLecture(String name){
    service.insertLecture(Lecture(name: name));
  }

  void insertExam(String date){
    service.insertExam(Exam(date: date, passed: false));
  }

  void insertTopic(String title){
    service.insertTopic(Topic(title: title));
  }


}