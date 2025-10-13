import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/errors/failure.dart';
import 'package:flutter_application_1/domain/entities/userrole.dart' hide User;
import 'package:flutter_application_1/domain/repositories/repositoryInterface.dart';
import 'package:flutter_application_1/user_account_domain.dart';

import '../repositories/userregister.dart' hide UserRepository;


class RegisterUseCase {
  final UserRepository repository;

  RegisterUseCase(this.repository);

  Future<Future<Either<Failure, User>>> call(String email, String password, dynamic role) async {
    // 'role' can be either a primitive value or a conversion to UserRole
    return await repository.register(email, password, role);
  }
}