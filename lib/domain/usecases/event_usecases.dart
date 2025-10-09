import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/errors/failure.dart';
import 'package:flutter_application_1/domain/entities/event.dart';
import 'package:flutter_application_1/domain/repositories/event_repository.dart';

class CreateEvent {
  final EventRepository repository;
  CreateEvent(this.repository);

  Future<Either<Failure, EventEntity>> call(EventEntity event) {
    return repository.createEvent(event);
  }
}

class UpdateEvent {
  final EventRepository repository;
  UpdateEvent(this.repository);

  Future<Either<Failure, EventEntity>> call(EventEntity event) {
    return repository.updateEvent(event);
  }
}

class DeleteEvent {
  final EventRepository repository;
  DeleteEvent(this.repository);

  Future<Either<Failure, void>> call(String eventId) {
    return repository.deleteEvent(eventId);
  }
}

class GetEvents {
  final EventRepository repository;
  GetEvents(this.repository);

  Future<Either<Failure, List<EventEntity>>> call() {
    return repository.getEvents();
  }
}

class GetEventById {
  final EventRepository repository;
  GetEventById(this.repository);

  Future<Either<Failure, EventEntity>> call(String eventId) {
    return repository.getEventById(eventId);
  }
}

class PublishEvent {
  final EventRepository repository;
  PublishEvent(this.repository);

  Future<Either<Failure, EventEntity>> call(String eventId, {bool publish = true}) {
    return repository.publishEvent(eventId, publish: publish);
  }
}

class RSVPToEvent {
  final EventRepository repository;
  RSVPToEvent(this.repository);

  Future<Either<Failure, EventEntity>> call({
    required String eventId,
    required String userId,
    required RSVPStatus status,
  }) {
    return repository.rsvpEvent(eventId: eventId, userId: userId, status: status);
  }
}

class MarkAttendance {
  final EventRepository repository;
  MarkAttendance(this.repository);

  Future<Either<Failure, EventEntity>> call({
    required String eventId,
    required String userId,
    required bool present,
  }) {
    return repository.markAttendance(eventId: eventId, userId: userId, present: present);
  }
}