import 'package:dartz/dartz.dart';
import '../../entities/announcement_entity.dart';
import '../../repositories/announcement_repository.dart';
import '../../../core/errors/failure.dart';

class GetAnnouncementsUseCase {
  final AnnouncementRepository repository;

  GetAnnouncementsUseCase(this.repository);

  Future<Either<Failure, List<Announcement>>> call() {
    return repository.getAnnouncements();
  }
}
