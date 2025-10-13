import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/usecases/announcement/get_announcement_detail_usecase.dart';
import '../../core/errors/failure.dart';
import '../entities/announcement_entity.dart';

abstract class AnnouncementRepository {
  Future<Either<Failure, List<Announcement>>> getAnnouncements();
  Future<Either<Failure, void>> createAnnouncement(Announcement announcement);

  Future<Either<Failure, AnnouncementEntity>> getAnnouncementDetail(String id) async {}

  Future<dynamic> sendAnnouncementNotification(AnnouncementEntity announcement) async {}

}
