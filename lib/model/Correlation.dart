/// Correlation class contains the correlation between lecture, exams and topics
/// [lectureId] is the lecture specifier that specifies which lecture exams and topics are assigned to
/// [examId] is the exam specifier used to assign an exam to a lecture and topics
/// [topicId] is the topic specifier used to assign a topic to a lecture and exams
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