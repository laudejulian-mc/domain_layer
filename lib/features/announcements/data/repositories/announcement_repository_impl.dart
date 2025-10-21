import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../../domain/entities/announcement_entity.dart';
import '../../domain/repositories/announcement_repository.dart';
import '../datasources/announcement_remote_data_source.dart';
import '../models/announcement_model.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final AnnouncementRemoteDataSource remoteDataSource;

  AnnouncementRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AnnouncementEntity>>> getAnnouncements() async {
    try {
      final result = await remoteDataSource.getAnnouncements();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AnnouncementEntity>> getAnnouncementDetail(String id) async {
    try {
      final result = await remoteDataSource.getAnnouncementDetail(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createAnnouncement(AnnouncementEntity announcement) async {
    try {
      final model = AnnouncementModel(
        id: announcement.id,
        title: announcement.title,
        description: announcement.description,
        datePosted: announcement.datePosted,
      );
      await remoteDataSource.createAnnouncement(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
