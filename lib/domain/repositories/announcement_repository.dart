import 'package:dartz/dartz.dart';
import '../entities/announcement.dart';
import '../failures/failure.dart';

abstract class AnnouncementRepository {
  Future<Either<Failure, List<Announcement>>> getAnnouncements();
  Future<Either<Failure, void>> createAnnouncement(Announcement announcement);
}
