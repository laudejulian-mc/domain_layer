import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';

import '../../domain/usecases/announcement/get_announcements_usecase.dart';
import '../../domain/usecases/announcement/get_announcement_detail_usecase.dart';
import '../../domain/usecases/announcement/create_announcement_usecase.dart';
import '../../domain/usecases/announcement/send_announcement_notification_usecase.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/announcement_entity.dart';
import 'announcement_state.dart';

class AnnouncementNotifier extends StateNotifier<AnnouncementsState> {
  final GetAnnouncementsUseCase getAnnouncements;
  final GetAnnouncementDetailUseCase getAnnouncementDetail;
  final CreateAnnouncementUseCase createAnnouncement;
  final SendAnnouncementNotificationUseCase sendAnnouncementNotification;

  AnnouncementNotifier({
    required this.getAnnouncements,
    required this.getAnnouncementDetail,
    required this.createAnnouncement,
    required this.sendAnnouncementNotification,
  }) : super(const AnnouncementsState());

  Future<void> loadAnnouncements() async {
    state = state.copyWith(status: AnnouncementStatus.loading, errorMessage: null);
    final Either<Failure, List<Announcement>> res = await getAnnouncements.call();
    res.fold((f) {
      state = state.copyWith(status: AnnouncementStatus.error, errorMessage: f.message);
    }, (list) {
      state = state.copyWith(status: AnnouncementStatus.loaded, announcements: list, errorMessage: null);
    });
  }

  Future<void> loadAnnouncementDetail(String id) async {
    state = state.copyWith(status: AnnouncementStatus.loading, errorMessage: null);
    final Either<Failure, Announcement> res = await getAnnouncementDetail.call(id);
    res.fold((f) {
      state = state.copyWith(status: AnnouncementStatus.error, errorMessage: f.message);
    }, (a) {
      state = state.copyWith(status: AnnouncementStatus.loaded, selected: a, errorMessage: null);
    });
  }

  Future<void> create(Announcement announcement) async {
    state = state.copyWith(status: AnnouncementStatus.loading, errorMessage: null);
    final Either<Failure, void> res = await createAnnouncement.call(announcement);
    res.fold((f) {
      state = state.copyWith(status: AnnouncementStatus.error, errorMessage: f.message);
    }, (_) async {
      await loadAnnouncements();
    });
  }

  Future<void> sendNotification(Announcement announcement) async {
    state = state.copyWith(status: AnnouncementStatus.loading, errorMessage: null);
    final Either<Failure, void> res = await sendAnnouncementNotification.call(announcement);
    res.fold((f) {
      state = state.copyWith(status: AnnouncementStatus.error, errorMessage: f.message);
    }, (_) async {
      // after sending notification, refresh list/state
      await loadAnnouncements();
    });
  }
}
