import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../entities/announcement_entity.dart';
import '../../repositories/announcement_repository.dart';
import 'get_announcement_detail_usecase.dart';


class SendAnnouncementNotificationUseCase {
  final AnnouncementRepository repository;
  SendAnnouncementNotificationUseCase(this.repository);

  Future call(AnnouncementEntity announcement) {
    return repository.sendAnnouncementNotification(announcement);
  }
}
