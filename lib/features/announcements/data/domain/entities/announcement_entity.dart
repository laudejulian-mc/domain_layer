import 'package:equatable/equatable.dart';

class AnnouncementEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime datePosted;

  const AnnouncementEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.datePosted,
  });

  @override
  List<Object?> get props => [id, title, description, datePosted];
}
