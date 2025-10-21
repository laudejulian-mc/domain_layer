import 'package:dartz/dartz.dart';
import '../entities/announcement_entity.dart';
import '../../../../core/failures/failure.dart';

abstract class AnnouncementRepository {
  Future<Either<Failure, List<AnnouncementEntity>>> getAnnouncements();
  Future<Either<Failure, AnnouncementEntity>> getAnnouncementDetail(String id);
  Future<Either<Failure, void>> createAnnouncement(AnnouncementEntity announcement);
}
