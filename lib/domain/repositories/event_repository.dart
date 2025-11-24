import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/event.dart';
import '../entities/schedule.dart';

abstract class EventRepository {
  Future<Either<Failure, List<Event>>> getEvents();
  Future<Either<Failure, Event>> getEventById(String id);
  Future<Either<Failure, List<Schedule>>> getSchedules();
  Future<Either<Failure, Schedule>> getScheduleById(String id);
}