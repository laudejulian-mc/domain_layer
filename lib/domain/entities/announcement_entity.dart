import 'package:equatable/equatable.dart';

class Announcement extends Equatable {
  final String id;
  final String title;
  final String message;
  final DateTime createdAt;

  const Announcement({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, message, createdAt];
}
