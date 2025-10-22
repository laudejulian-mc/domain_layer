import 'package:cloud_firestore/cloud_firestore.dart';
import 'event_remote_data_source.dart';
import '../models/event_model.dart';
import '../models/schedule_model.dart';

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final FirebaseFirestore firestore;

  EventRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<EventModel>> fetchEvents() async {
    final snapshot = await firestore.collection('events').get();
    return snapshot.docs
        .map((doc) => EventModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<ScheduleModel>> fetchSchedules() async {
    final snapshot = await firestore.collection('schedules').get();
    return snapshot.docs
        .map((doc) => ScheduleModel.fromJson(doc.data()))
        .toList();
  }
}