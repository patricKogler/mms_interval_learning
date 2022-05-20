class Question {
  final int? id;
  String text;
  String? mediaPath;
  final int? topicId;

  Question({this.id, required this.text, this.mediaPath, this.topicId});

  Question.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      text = map["text"],
      mediaPath = map["media"],
      topicId = map["Topic.id"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "text": text,
      "media": mediaPath,
      "Topic.id": topicId
    };
  }
}