import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';
import '../failures/failure.dart';

class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<Either<Failure, User>> call(String id) async {
    return await repository.getUserProfile(id);
  }
}