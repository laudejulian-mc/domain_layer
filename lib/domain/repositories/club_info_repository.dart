import 'package:dartz/dartz.dart';
import '../entities/club_info.dart';
import '../entities/failure.dart';

abstract class ClubInfoRepository {
  Future<Either<Failure, ClubInfo>> getClubInfo();
}
