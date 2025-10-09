import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/errors/failure.dart';
import '../entities/club_info.dart';


abstract class ClubInfoRepository {
  Future<Either<Failure, ClubInfo>> getClubInfo();
}
