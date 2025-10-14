import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/domain_layer/data/schedule/datasources/schedule_data_source.dart';
import 'package:flutter_application_1/domain_layer/domain_layer/entities/schedule_entity.dart';
import 'package:flutter_application_1/domain_layer/domain_layer/repositories/schedule_repository.dart';
import 'package:flutter_application_1/domain_layer/data/schedule/models/schedule_model.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleDataSource dataSource;

  ScheduleRepositoryImpl(this.dataSource);

  @override
  Future<List<ScheduleModel>> getSchedules() async {
    final schedules = await dataSource.getSchedules();
    return schedules;
  }

  @override
  Future<ScheduleModel> getScheduleById(String id) async {
    final schedule = await dataSource.getScheduleById(id);
    return schedule;
  }

  @override
  Future<void> createSchedule(ScheduleModel schedule) async {
    await dataSource.createSchedule(schedule);
  }

  @override
  Future<void> updateSchedule(ScheduleModel schedule) async {
    await dataSource.updateSchedule(schedule);
  }

  @override
  Future<void> deleteSchedule(String id) async {
    await dataSource.deleteSchedule(id);
  }
}