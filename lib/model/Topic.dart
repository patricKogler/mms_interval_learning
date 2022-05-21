/// Topic class contains basic information on topics
/// [id] is an unique specifier for each topic in the database
/// [title] is the user generated title of the topic
class Topic {
  final int? id;
  String title;

  Topic({this.id, required this.title});

  Topic.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      title = map["title"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title
    };
  }
}