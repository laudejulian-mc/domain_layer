import 'package:dartz/dartz.dart';
import '../../domain/entities/announcement.dart';
import '../../domain/repositories/announcement_repository.dart';
import '../datasources/announcement_remote_datasource.dart';
import '../models/announcement_model.dart';
import '../../../../core/error/failure.dart'; // adjust path to match your core folder

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final AnnouncementRemoteDataSource remoteDataSource;

  AnnouncementRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Announcement>>> getAnnouncements() async {
    try {
      final models = await remoteDataSource.getAnnouncements();
      return Right(models.map((m) => m as Announcement).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createAnnouncement(
      Announcement announcement) async {
    try {
      final model = AnnouncementModel(
        id: announcement.id,
        title: announcement.title,
        message: announcement.message,
        imageUrl: announcement.imageUrl,
        linkUrl: announcement.linkUrl,
        createdAt: announcement.createdAt,
        createdBy: announcement.createdBy,
      );
      await remoteDataSource.createAnnouncement(model);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAnnouncement(String id) async {
    try {
      await remoteDataSource.deleteAnnouncement(id);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
