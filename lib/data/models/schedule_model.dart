import '../../domain/entities/schedule.dart';

class ScheduleModel {
  final String id;
  final DateTime startAt;
  final DateTime endAt;
  final String location;

  ScheduleModel({
    required this.id,
    required this.startAt,
    required this.endAt,
    required this.location,
  });

  Schedule toEntity() => Schedule(
        id: id,
        startAt: startAt,
        endAt: endAt,
        location: location,
      );

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] as String,
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startAt': startAt.toIso8601String(),
      'endAt': endAt.toIso8601String(),
      'location': location,
    };
  }
}