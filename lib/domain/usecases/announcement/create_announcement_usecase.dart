import 'package:dartz/dartz.dart';
import '../../entities/announcement_entity.dart';
import '../../repositories/announcement_repository.dart';
import '../../../core/errors/failure.dart';

class CreateAnnouncementUseCase {
  final AnnouncementRepository repository;

  CreateAnnouncementUseCase(this.repository);

  Future<Either<Failure, void>> call(Announcement announcement) {
    return repository.createAnnouncement(announcement);
  }
}
