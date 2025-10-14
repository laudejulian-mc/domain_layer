import 'package:cloud_firestore/cloud_firestore.dart';
import 'schedule_data_source.dart';
import '../models/schedule_model.dart';

class ScheduleDataSourceImpl implements ScheduleDataSource {
  final FirebaseFirestore firestore;

  ScheduleDataSourceImpl({required this.firestore});

  @override
  Future<List<ScheduleModel>> getSchedules() async {
    final snapshot = await firestore.collection('schedules').get();
    return snapshot.docs
        .map((doc) => ScheduleModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ScheduleModel> getScheduleById(String id) async {
    final doc = await firestore.collection('schedules').doc(id).get();
    return ScheduleModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  @override
  Future<void> createSchedule(ScheduleModel schedule) async {
    await firestore.collection('schedules').add(schedule.toJson());
  }

  @override
  Future<void> updateSchedule(String id, ScheduleModel schedule) async {
    await firestore.collection('schedules').doc(id).update(schedule.toJson());
  }

  @override
  Future<void> deleteSchedule(String id) async {
    await firestore.collection('schedules').doc(id).delete();
  }
}