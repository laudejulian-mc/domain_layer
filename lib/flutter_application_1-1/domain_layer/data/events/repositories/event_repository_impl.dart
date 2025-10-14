import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_project_name/data/events/datasources/event_data_source.dart';
import 'package:your_project_name/domain/domain_layer/entities/event.dart';
import 'package:your_project_name/data/events/models/event_model.dart';
import 'package:dartz/dartz.dart';
import 'package:your_project_name/core/errors/failure.dart';
import 'package:your_project_name/domain/domain_layer/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventDataSource dataSource;

  EventRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<EventModel>>> getEvents() async {
    try {
      final events = await dataSource.getEvents();
      return Right(events);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, EventModel>> getEventById(String id) async {
    try {
      final event = await dataSource.getEventById(id);
      return Right(event);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createEvent(EventModel event) async {
    try {
      await dataSource.createEvent(event);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateEvent(EventModel event) async {
    try {
      await dataSource.updateEvent(event);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteEvent(String id) async {
    try {
      await dataSource.deleteEvent(id);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}