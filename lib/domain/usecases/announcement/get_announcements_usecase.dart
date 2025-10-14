import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/entities/announcement_entity.dart';

import '../../repositories/announcement_repository.dart';

class GetAnnouncementsUseCase {
  final AnnouncementRepository repository;

  GetAnnouncementsUseCase(this.repository);

  Future call() {
    return repository.getAnnouncements();
  }
}
