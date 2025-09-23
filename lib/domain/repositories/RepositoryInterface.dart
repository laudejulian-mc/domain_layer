import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../failures/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(String email, String password, UserRole role);
  Future<Either<Failure, User>> getUserProfile(String id);
}