import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/errors/failure.dart';

import '../entities/userrole.dart' show User;
import '../repositories/repositoryInterface.dart';

class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<Either<Failure, User>> call(String id) async {
    return await repository.getUserProfile(id);
  }
}