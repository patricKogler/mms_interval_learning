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
