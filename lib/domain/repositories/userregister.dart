import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/entities/userrole.dart' hide User, UserRole;
import 'package:flutter_application_1/user_account_domain.dart' show User, UserRole;

import '../../core/errors/failure.dart' show Failure;

abstract class UserRepository {
  Future<Either<Failure, User>> registerUser({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  });

  Future<Either<Failure, User>> loginUser({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> getUserProfile(String userId);

  Future<Either<Failure, User>> updateUserProfile(User user);

  Future<Either<Failure, void>> logoutUser();

  Future<Future<Either<Failure, User>>> login(String email, String password) async {}

  Future<Future<Either<Failure, User>>> register(String email, String password, role) async {}
}