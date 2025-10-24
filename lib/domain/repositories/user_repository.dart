import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../core/errors/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, User>> signInWithEmail(String email, String password);
  Future<Either<Failure, User>> registerUser(User user, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, User>> updateProfile(User user);
}