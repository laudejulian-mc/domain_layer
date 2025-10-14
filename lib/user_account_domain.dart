import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';


/// Failure base class
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// User roles
enum UserRole { client, admin, coach, organizer }

/// User entity
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? photoUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [id, name, email, role, photoUrl];
}

/// Repository interface
abstract class UserRepository {
  Future<Either<Failure, User>> registerUser({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  });

  Future<Either<Failure, User>> loginUser({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> getUserProfile(String userId);

  Future<Either<Failure, User>> updateUserProfile(User user);

  Future<Either<Failure, void>> logoutUser();

  Future<Either<Failure, User>> register(String email, String password, UserRole role);
}

/// Use cases
class RegisterUser {
  final UserRepository repository;
  RegisterUser(this.repository);

  Future<Either<Failure, User>> call({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) {
    return repository.registerUser(
      name: name,
      email: email,
      password: password,
      role: role,
    );
  }
}

class LoginUser {
  final UserRepository repository;
  LoginUser(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) {
    return repository.loginUser(
      email: email,
      password: password,
    );
  }
}

class GetUserProfile {
  final UserRepository repository;
  GetUserProfile(this.repository);

  Future<Either<Failure, User>> call(String userId) {
    return repository.getUserProfile(userId);
  }
}

class UpdateUserProfile {
  final UserRepository repository;
  UpdateUserProfile(this.repository);

  Future<Either<Failure, User>> call(User user) {
    return repository.updateUserProfile(user);
  }
}

class LogoutUser {
  final UserRepository repository;
  LogoutUser(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.logoutUser();
  }
}