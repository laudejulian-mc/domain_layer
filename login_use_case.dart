import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';
import '../failures/failure.dart';

class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}