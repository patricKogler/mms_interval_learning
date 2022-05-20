class Correlation {
  final int lectureId;
  final int examId;
  final int topicId;

  Correlation(this.lectureId, this.examId, this.topicId);

  Correlation.fromMap(Map<String, dynamic> map)
    : lectureId = map["Lecture.id"],
      examId = map["Exam.id"],
      topicId = map["Topic.id"];

  Map<String, dynamic> toMap() {
    return {
      "Lecture.id": lectureId,
      "Exam.id": examId,
      "Topic.id": topicId
    };
  }
}