import 'package:equatable/equatable.dart';

enum EventType { practice, game, tournament, meetup, other }
enum RSVPStatus { yes, no, maybe, none }

class RSVP extends Equatable {
  final String userId;
  final RSVPStatus status;

  const RSVP({
    required this.userId,
    required this.status,
  });

  @override
  List<Object?> get props => [userId, status];
}

class EventEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final EventType type;
  final DateTime start;
  final DateTime? end;
  final String venue;
  final String organizerId;
  final bool isPublished;
  final List<RSVP> rsvps;
  final List<String> attendance; // userIds checked-in after event

  const EventEntity({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.start,
    this.end,
    required this.venue,
    required this.organizerId,
    this.isPublished = false,
    this.rsvps = const [],
    this.attendance = const [],
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        start,
        end,
        venue,
        organizerId,
        isPublished,
        rsvps,
        attendance,
      ];

  EventEntity copyWith({
    String? id,
    String? title,
    String? description,
    EventType? type,
    DateTime? start,
    DateTime? end,
    String? venue,
    String? organizerId,
    bool? isPublished,
    List<RSVP>? rsvps,
    List<String>? attendance,
  }) {
    return EventEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      start: start ?? this.start,
      end: end ?? this.end,
      venue: venue ?? this.venue,
      organizerId: organizerId ?? this.organizerId,
      isPublished: isPublished ?? this.isPublished,
      rsvps: rsvps ?? this.rsvps,
      attendance: attendance ?? this.attendance,
    );
  }
}