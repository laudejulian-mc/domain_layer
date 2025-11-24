// TODO: Implement send announcement notification use case
import 'package:dartz/dartz.dart';
import '../../entities/announcement_entity.dart';
import '../../repositories/announcement_repository.dart';
import '../../../core/errors/failure.dart';

class SendAnnouncementNotificationUseCase {
  final AnnouncementRepository repository;

  SendAnnouncementNotificationUseCase(this.repository);

  Future<Either<Failure, void>> call(Announcement announcement) async {
    // TODO: Implement the logic to send notification
    return repository.sendAnnouncementNotification(announcement);
  }
}

