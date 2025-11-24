import 'package:dartz/dartz.dart';
import '../../entities/announcement_entity.dart';
import '../../repositories/announcement_repository.dart';
import '../../../core/errors/failure.dart';

class GetAnnouncementDetailUseCase {
  final AnnouncementRepository repository;

  GetAnnouncementDetailUseCase(this.repository);

  Future<Either<Failure, Announcement>> call(String id) {
    return repository.getAnnouncementDetail(id);
  }
}
