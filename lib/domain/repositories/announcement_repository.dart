import 'package:dartz/dartz.dart';
import 'package:hoophub/domain/entities/announcement_entity.dart';

import '../../core/errors/failure.dart';


abstract class AnnouncementRepository {
  Future<Either<Failure, List<Announcement>>> getAnnouncements();
  Future<Either<Failure, void>> createAnnouncement(Announcement announcement);

  Future<Either<Failure, Announcement>> getAnnouncementDetail(String id);

  Future<Either<Failure, void>> sendAnnouncementNotification(Announcement announcement);
}
