import 'package:dartz/dartz.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/entities/user.dart';
import '../../core/errors/failure.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Right(userModel);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmail(String email, String password) async {
    try {
      final userModel = await remoteDataSource.signInWithEmail(email, password);
      return Right(userModel);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> registerUser(User user, String password) async {
    try {
      final userModel = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        photoUrl: user.photoUrl,
      );
      final registeredUser = await remoteDataSource.registerUser(userModel, password);
      return Right(registeredUser);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile(User user) async {
    try {
      final userModel = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        photoUrl: user.photoUrl,
      );
      final updatedUser = await remoteDataSource.updateProfile(userModel);
      return Right(updatedUser);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUserProfile(String id) {
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> register(String email, String password, UserRole role) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
