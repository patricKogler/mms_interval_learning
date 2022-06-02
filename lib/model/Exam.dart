/// Exam class contains basic information on exams
/// [id] is an unique specifier for each exam in the database
/// [date] is the exam date specified by the user
/// [passed] indicates if the user has passed an exam or not
class Exam {
  final int? id;
  final int lectureId;
  String date;
  bool passed;

  Exam({this.id,
      required this.lectureId,
      required this.date,
      required this.passed});

  /// retrieves data from database in form of a map
  Exam.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        lectureId = map["lecture_id"],
        date = map["date"],
        passed = map["passed"] == 0 ? false : true;

  /// returns map to use in database for inserts
  /// must contain column names as Strings
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "lecture_id": lectureId,
      "date": date,
      "passed": passed ? 1 : 0
    };
  }

  @override
  String toString() {
    return "{[id: $id; lecture_id: $lectureId; date: $date; passed: $passed]}";
  }
}
