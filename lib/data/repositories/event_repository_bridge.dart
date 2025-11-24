import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../../features/events/domain/repositories/event_repository.dart' as iface;
import '../datasources/event_remote_data_source_impl.dart' show EventRemoteDataSourceImpl;
import '../../features/events/domain/entities/event.dart' as entities;

class EventRepositoryBridge implements iface.EventRepository {
  final EventRemoteDataSourceImpl remoteDataSource;

  EventRepositoryBridge(this.remoteDataSource);

  @override
  Future<Either<Failure, entities.EventEntity>> createEvent(entities.EventEntity event) async {
    return Left(SimpleFailure('createEvent not implemented in bridge'));
  }

  @override
  Future<Either<Failure, entities.EventEntity>> deleteEvent(String eventId) async {
    return Left(SimpleFailure('deleteEvent not implemented in bridge'));
  }

  @override
  Future<Either<Failure, entities.EventEntity>> getEventById(String eventId) async {
    try {
      final models = await remoteDataSource.fetchEvents();
      final foundIndex = models.indexWhere((m) => m.id == eventId);
      if (foundIndex == -1) return Left(SimpleFailure('Event not found: $eventId'));
      final found = models[foundIndex];
      final entity = _mapModelToEntity(found);
      return Right(entity);
    } catch (e) {
      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<entities.EventEntity>>> getEvents() async {
    try {
      final models = await remoteDataSource.fetchEvents();
      final list = models.map((m) => _mapModelToEntity(m)).toList();
      return Right(list);
    } catch (e) {
      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, entities.EventEntity>> publishEvent(String eventId, {bool publish = true}) async {
    return Left(SimpleFailure('publishEvent not implemented in bridge'));
  }

  @override
  Future<Either<Failure, entities.EventEntity>> rsvpEvent({required String eventId, required String userId, required entities.RSVPStatus status}) async {
    return Left(SimpleFailure('rsvpEvent not implemented in bridge'));
  }

  @override
  Future<Either<Failure, entities.EventEntity>> markAttendance({required String eventId, required String userId, required bool present}) async {
    return Left(SimpleFailure('markAttendance not implemented in bridge'));
  }

  @override
  Future<Either<Failure, entities.EventEntity>> updateEvent(entities.EventEntity event) async {
    return Left(SimpleFailure('updateEvent not implemented in bridge'));
  }

  entities.EventEntity _mapModelToEntity(dynamic m) {
    // Attempt to map fields from model to entity with safe defaults
    try {
      final id = m.id ?? '';
      final title = m.title ?? '';
      final description = m.description as String?;
      final DateTime start = (m.date is DateTime) ? m.date : DateTime.tryParse(m.date ?? '') ?? DateTime.now();
      return entities.EventEntity(
        id: id,
        title: title,
        description: description,
        type: entities.EventType.other,
        start: start,
        end: null,
        venue: '',
        organizerId: '',
      );
    } catch (_) {
      return entities.EventEntity(
        id: '',
        title: 'Unknown',
        description: null,
        type: entities.EventType.other,
        start: DateTime.now(),
        end: null,
        venue: '',
        organizerId: '',
      );
    }
  }
}
