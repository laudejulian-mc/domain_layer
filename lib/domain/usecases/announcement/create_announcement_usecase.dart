import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/errors/failure.dart';
import 'package:flutter_application_1/domain/entities/announcement_entity.dart' show Announcement;

import '../../repositories/announcement_repository.dart';

class GetAnnouncementsUseCase {
  final AnnouncementRepository repository;

  GetAnnouncementsUseCase(this.repository);

  Future<Either<Failure, List<Announcement>>> call() {
    return repository.getAnnouncements();
  }
}
