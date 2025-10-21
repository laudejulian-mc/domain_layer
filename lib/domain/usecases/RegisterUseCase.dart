import 'package:dartz/dartz.dart';
import 'package:hoophub/core/errors/failure.dart';
import 'package:hoophub/domain/entities/UserEntity.dart';
import 'package:hoophub/domain/repositories/repositoryInterface.dart' show UserRepository;
import '../../core/errors/failure.dart' hide Failure;

import '../entities/user.dart';


class RegisterUseCase {
  final UserRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password, dynamic role) async {
    // 'role' can be either a primitive value or a conversion to UserRole
    return await repository.register(email, password, role);
  }
}