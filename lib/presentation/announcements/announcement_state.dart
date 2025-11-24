import 'package:equatable/equatable.dart';
import '../../domain/entities/announcement_entity.dart';

enum AnnouncementStatus { initial, loading, loaded, error }

class AnnouncementsState extends Equatable {
  final AnnouncementStatus status;
  final List<Announcement> announcements;
  final Announcement? selected;
  final String? errorMessage;

  const AnnouncementsState({
    this.status = AnnouncementStatus.initial,
    this.announcements = const [],
    this.selected,
    this.errorMessage,
  });

  AnnouncementsState copyWith({
    AnnouncementStatus? status,
    List<Announcement>? announcements,
    Announcement? selected,
    String? errorMessage,
  }) {
    return AnnouncementsState(
      status: status ?? this.status,
      announcements: announcements ?? this.announcements,
      selected: selected ?? this.selected,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, announcements, selected, errorMessage];
}
