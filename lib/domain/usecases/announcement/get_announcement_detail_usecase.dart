import '../../entities/announcement_entity.dart';
import '../../repositories/announcement_repository.dart';
import '../../entities/either.dart';
import '../../entities/Failure.dart';

class GetAnnouncementDetailUseCase {
  final AnnouncementRepository repository;
  GetAnnouncementDetailUseCase(this.repository);

  Future call(String id) {
    return repository.getAnnouncementDetail(id);
  }
}

class AnnouncementEntity {
}
