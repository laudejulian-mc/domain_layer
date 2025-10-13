import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/errors/failure.dart';
import 'package:flutter_application_1/domain/repositories/repositoryInterface.dart';
import 'package:flutter_application_1/domain/repositories/userregister.dart';

class LogoutUser {
  final UserRepository repository;
  LogoutUser(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.logout();
  }
}

/// Minimal repository interface for logout used by LogoutUser.
/// Move this to a shared repository file if you have a central interface.
abstract class UserRepository {
  Future<Either<Failure, void>> logout();
}