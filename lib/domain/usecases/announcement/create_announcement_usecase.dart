import 'package:dartz/dartz.dart';
import '../../entities/announcement.dart';
import '../../repositories/announcement_repository.dart';

class GetAnnouncementsUseCase {
  final AnnouncementRepository repository;

  GetAnnouncementsUseCase(this.repository);

  Future<Either<Exception, List<Announcement>>> call() {
    return repository.getAnnouncements();
  }
}
