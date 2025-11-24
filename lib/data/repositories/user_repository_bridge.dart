import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/RepositoryInterface.dart' as repo_iface;
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryBridge implements repo_iface.UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryBridge(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> getUserProfile(String id) async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      // Note: remoteDataSource.getCurrentUser reads currently signed-in user.
      // If you need to fetch by id, implement appropriate datasource method.
      return Right(userModel);
    } catch (e) {
      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await remoteDataSource.signInWithEmail(email, password);
      return Right(userModel);
    } catch (e) {
      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register(String email, String password, UserRole role) async {
    try {
      // Build a minimal User entity/model for registration; remote datasource expects a UserModel.
      final userModel = UserModel(id: '', name: email.split('@').first, email: email, role: role, photoUrl: null);
      final registered = await remoteDataSource.registerUser(userModel, password);
      // registerUser expects a UserModel; data layer may accept User too depending on implementation.
      return Right(registered);
    } catch (e) {
      return Left(SimpleFailure(e.toString()));
    }
  }
}
