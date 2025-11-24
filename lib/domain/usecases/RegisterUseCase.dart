import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/RepositoryInterface.dart';

class RegisterUseCase {
  final UserRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password, UserRole role) async {
    return await repository.register(email, password, role);
  }
}
