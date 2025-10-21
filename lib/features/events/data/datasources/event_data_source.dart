// This file defines the EventDataSource interface, which declares methods for interacting with event data in Firebase.

abstract class EventDataSource {
  Future<List<EventModel>> getEvents();
  Future<EventModel> getEventById(String id);
  Future<void> createEvent(EventModel event);
  Future<void> updateEvent(EventModel event);
  Future<void> deleteEvent(String id);
}