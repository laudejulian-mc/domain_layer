import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/errors/failure.dart';
import 'package:flutter_application_1/domain/repositories/repositoryInterface.dart';

class LogoutUser {
  final UserRepository repository;
  LogoutUser(this.repository);

}