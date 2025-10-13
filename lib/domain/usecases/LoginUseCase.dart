import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/entities/userrole.dart' hide User;
import 'package:flutter_application_1/domain/repositories/repositoryInterface.dart' show UserRepository;
import 'package:flutter_application_1/domain/repositories/userregister.dart' hide UserRepository;
import 'package:flutter_application_1/user_account_domain.dart';

import '../../core/errors/failure.dart' show Failure;


class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}