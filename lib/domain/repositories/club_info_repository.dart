import 'package:dartz/dartz.dart';
import 'package:hoophub/core/errors/failure.dart';
import '../entities/club_info.dart';


abstract class ClubInfoRepository {
  Future<Either<Failure, ClubInfo>> getClubInfo();
}
