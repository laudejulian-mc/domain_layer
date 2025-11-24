import '../../domain/entities/event.dart';

class EventModel {
  final String id;
  final String title;
  final String? description;
  final DateTime startAt;
  final DateTime? endAt;

  EventModel({
    required this.id,
    required this.title,
    this.description,
    required this.startAt,
    this.endAt,
  });

  Event toEntity() => Event(
        id: id,
        title: title,
        description: description,
        startAt: startAt,
        endAt: endAt,
      );

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: json['endAt'] != null ? DateTime.parse(json['endAt'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startAt': startAt.toIso8601String(),
      'endAt': endAt?.toIso8601String(),
    };
  }
}