import 'package:dartz/dartz.dart';
import 'package:hoophub/core/errors/failure.dart';
import 'package:hoophub/domain/entities/UserEntity.dart';
import 'package:hoophub/domain/repositories/repositoryInterface.dart' show UserRepository;


import '../../core/errors/failure.dart' hide Failure;
import '../entities/user.dart';
import '../repositories/RepositoryInterface.dart' hide UserRepository;



class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}