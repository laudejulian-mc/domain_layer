import 'package:dartz/dartz.dart';
import '../entities/club_info.dart';
import '../entities/failure.dart';
import '../repositories/club_info_repository.dart';

class GetClubInfo {
  final ClubInfoRepository repository;

  GetClubInfo(this.repository);

  Future<Either<Failure, ClubInfo>> call() {
    return repository.getClubInfo();
  }
}
