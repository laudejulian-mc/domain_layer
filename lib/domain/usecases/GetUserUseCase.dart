// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart' show Failure;
import '../entities/user.dart';
import '../repositories/RepositoryInterface.dart';

class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<Either<Failure, User>> call(String id) async {
    return await repository.getUserProfile(id);
  }
}
