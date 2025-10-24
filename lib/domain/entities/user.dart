import 'package:equatable/equatable.dart';

enum UserRole { client, admin }

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
