import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../entities/announcement_entity.dart';
import '../../repositories/announcement_repository.dart';


class GetAnnouncementDetailUseCase {
  final AnnouncementRepository repository;
  GetAnnouncementDetailUseCase(this.repository);

  Future<Either<Failure, AnnouncementEntity>> call(String id) {
    return repository.getAnnouncementDetail(id);
  }
}

class AnnouncementEntity {
}
