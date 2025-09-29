import '../../entities/announcement_entity.dart';
import '../../repositories/announcement_repository.dart';
import '../../entities/either.dart';
import '../../entities/Failure.dart';

class SendAnnouncementNotificationUseCase {
  final AnnouncementRepository repository;
  SendAnnouncementNotificationUseCase(this.repository);

  Future<Either<Failure, void>> call(AnnouncementEntity announcement) {
    return repository.sendAnnouncementNotification(announcement);
  }
}
