class ScheduleModel extends ScheduleEntity {
  final String id;
  final String eventId;
  final DateTime startTime;
  final DateTime endTime;

  ScheduleModel({
    required this.id,
    required this.eventId,
    required this.startTime,
    required this.endTime,
  }) : super(id: id, eventId: eventId, startTime: startTime, endTime: endTime);

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'],
      eventId: json['eventId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }
}