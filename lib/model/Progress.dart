/// Progress class contains basic information on the progress made by the user
/// [id] is an unique specifier for the progress made on each question in the database
/// [evaluation] is the value that assesses the difficulty of a question updated by the user
/// [date] is the date the progress was made on
/// [questionId] connects the progress to the corresponding question
class Progress {
  final int? id;
  final double evaluation;
  final String date;
  final int? questionId;

  Progress({this.id, required this.evaluation, required this.date, this.questionId});

  /// retrieves data from database in form of a map
  Progress.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      evaluation = map["evaluation"],
      date = map["date"],
      questionId = map["question_id"];

  /// returns map to use in database for inserts
  /// must contain column names as Strings
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "evaluation": evaluation,
      "date": date,
      "question_id": questionId
    };
  }

  @override
  String toString() {
    return "{[id: $id; evaluation: $evaluation; date: $date; questions_id: $questionId]}";
  }
}