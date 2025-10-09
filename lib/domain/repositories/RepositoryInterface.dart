// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/errors/failure.dart';
import 'package:flutter_application_1/domain/entities/userrole.dart';


abstract class UserRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(String email, String password, UserRole role);
  Future<Either<Failure, User>> getUserProfile(String id);

  Future<Either<Failure, void>> logoutUser() async {}

  Future<Either<Failure, void>> logoutUser() async {}

  Future<Either<Failure, void>> logoutUser() async {}
}
  