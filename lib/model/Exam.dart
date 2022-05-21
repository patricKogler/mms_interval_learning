/// Exam class contains basic information on exams
/// [id] is an unique specifier for each exam in the database
/// [date] is the exam date specified by the user
/// [passed] indicates if the user has passed an exam or not
class Exam {
  final int? id;
  String date;
  bool passed;

  Exam({this.id, required this.date, required this.passed});

  Exam.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      date = map["date"],
      passed = map["passed"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date,
      "passed": passed
    };
  }
}
