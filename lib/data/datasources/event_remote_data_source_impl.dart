import 'package:cloud_firestore/cloud_firestore.dart';
import 'event_remote_data_source.dart';
import '../models/event_model.dart';
import '../models/schedule_model.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/schedule.dart';

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final FirebaseFirestore firestore;

  EventRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Event>> fetchEvents() async {
    final snapshot = await firestore.collection('events').get();
    return snapshot.docs
        .map((doc) => EventModel.fromJson(doc.data()).toEntity())
        .toList();
  }

  @override
  Future<List<Schedule>> fetchSchedules() async {
    final snapshot = await firestore.collection('schedules').get();
    return snapshot.docs
        .map((doc) => ScheduleModel.fromJson(doc.data()).toEntity())
        .toList();
  }

  @override
  Future<Event> fetchEventById(String id) async {
    final doc = await firestore.collection('events').doc(id).get();
    return EventModel.fromJson(doc.data() ?? {}).toEntity();
  }

  @override
  Future<Schedule> fetchScheduleById(String id) async {
    final doc = await firestore.collection('schedules').doc(id).get();
    return ScheduleModel.fromJson(doc.data() ?? {}).toEntity();
  }
}