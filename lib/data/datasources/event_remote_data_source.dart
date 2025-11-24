import '../../domain/entities/event.dart';
import '../../domain/entities/schedule.dart';

abstract class EventRemoteDataSource {
  Future<List<Event>> fetchEvents();
  Future<Event> fetchEventById(String id);
  Future<List<Schedule>> fetchSchedules();
  Future<Schedule> fetchScheduleById(String id);
}
