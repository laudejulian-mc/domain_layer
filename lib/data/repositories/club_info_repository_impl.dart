import 'package:dartz/dartz.dart';
import '../../domain/repositories/club_info_repository.dart';
import '../../domain/entities/club_info.dart';
import '../../core/errors/failure.dart';
import '../datasources/club_info_remote_data_source.dart';
import '../models/club_info_model.dart';

class ClubInfoRepositoryImpl implements ClubInfoRepository {
  final ClubInfoRemoteDataSource remoteDataSource;

  ClubInfoRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ClubInfo>> getClubInfo() async {
    try {
      final clubInfoModel = await remoteDataSource.getClubInfo();
      return Right(clubInfoModel);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
