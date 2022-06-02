/// Question class contains basic information on questions
/// [id] is an unique specifier for each question in the database
/// [text] is the user generated body of the question
/// [mediaPath] is the path to a media file, e.g. picture or audio
/// [topicId] assigns the question to one of the existing topics
class Question {
  final int? id;
  String text;
  String? mediaPath;
  final int? topicId;

  Question({this.id, required this.text, this.mediaPath, this.topicId});

  /// retrieves data from database in form of a map
  Question.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        text = map["text"],
        mediaPath = map["media"],
        topicId = map["topic_id"];

  /// returns map to use in database for inserts
  /// must contain column names as Strings
  Map<String, dynamic> toMap() {
    return {"id": id, "text": text, "media": mediaPath, "topic_id": topicId};
  }

  @override
  String toString() {
    return "{[id: $id; text: $text; media: $mediaPath; topic_id: $topicId]}";
  }

  Question copyWith({int? id, String? text, String? mediaPath, int? topicId}) {
    return Question(
        id: id ?? this.id,
        text: text ?? this.text,
        mediaPath: mediaPath ?? this.mediaPath,
        topicId: topicId ?? this.topicId);
  }
}
