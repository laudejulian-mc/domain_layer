abstract class EventRepository {
  Future<List<EventModel>> getEvents();
  Future<EventModel> getEventById(String id);
  Future<List<ScheduleModel>> getSchedules();
  Future<ScheduleModel> getScheduleById(String id);
}