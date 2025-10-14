import 'package:dartz/dartz.dart';
import 'package:hoophub/user_account_domain.dart';

import '../../core/errors/failure.dart' hide Failure;
import '../entities/user.dart';
import '../repositories/RepositoryInterface.dart' hide UserRepository;



class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<Future<Either<Failure, User>>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}