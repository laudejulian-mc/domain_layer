// This file defines the ScheduleDataSource interface, which declares methods for interacting with schedule data in Firebase.

abstract class ScheduleDataSource {
  Future<List<ScheduleModel>> getSchedules();
  Future<ScheduleModel> getScheduleById(String id);
  Future<void> createSchedule(ScheduleModel schedule);
  Future<void> updateSchedule(ScheduleModel schedule);
  Future<void> deleteSchedule(String id);
}