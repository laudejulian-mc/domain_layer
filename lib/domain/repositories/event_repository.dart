import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/errors/failure.dart';
import 'package:flutter_application_1/domain/entities/event.dart';

abstract class EventRepository {
  Future<Either<Failure, EventEntity>> createEvent(EventEntity event);
  Future<Either<Failure, EventEntity>> updateEvent(EventEntity event);
  Future<Either<Failure, void>> deleteEvent(String eventId);

  Future<Either<Failure, List<EventEntity>>> getEvents(); // could accept filters later
  Future<Either<Failure, EventEntity>> getEventById(String eventId);

  Future<Either<Failure, EventEntity>> publishEvent(String eventId, {bool publish = true});

  Future<Either<Failure, EventEntity>> rsvpEvent({
    required String eventId,
    required String userId,
    required RSVPStatus status,
  });

  Future<Either<Failure, EventEntity>> markAttendance({
    required String eventId,
    required String userId,
    required bool present,
  });
}