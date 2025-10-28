import 'package:your_project_name/domain/entities/schedule.dart';

class ScheduleModel extends Schedule {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  ScheduleModel({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
  }) : super(id: id, title: title, startTime: startTime, endTime: endTime);

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'],
      title: json['title'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }
}