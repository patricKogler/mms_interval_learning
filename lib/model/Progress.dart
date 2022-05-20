class Progress {
  final int? id;
  final double evaluation;
  final String date;
  final int? questionId;

  Progress({this.id, required this.evaluation, required this.date, this.questionId});

  Progress.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      evaluation = map["evaluation"],
      date = map["date"],
      questionId = map["Questions.id"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "evaluation": evaluation,
      "date": date,
      "Questions.id": questionId
    };
  }
}