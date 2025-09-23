import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';
import '../failures/failure.dart';

class RegisterUseCase {
  final UserRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password, dynamic role) async {
    // 'role' can be either a primitive value or a conversion to UserRole
    return await repository.register(email, password, role);
  }
}