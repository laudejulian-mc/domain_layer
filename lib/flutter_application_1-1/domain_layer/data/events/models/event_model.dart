class EventModel extends EventEntity {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  }) : super(id: id, title: title, description: description, date: date);

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }
}