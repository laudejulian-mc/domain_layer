import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/repositories/announcement_repository_bridge.dart';
import '../../domain/usecases/announcement/get_announcements_usecase.dart';
import '../../domain/usecases/announcement/get_announcement_detail_usecase.dart';
import '../../domain/usecases/announcement/create_announcement_usecase.dart';
import '../../domain/usecases/announcement/send_announcement_notification_usecase.dart';
import 'announcement_notifier.dart';
import 'announcement_state.dart';

final announcementsFirestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final announcementRepositoryProvider = Provider((ref) {
  return AnnouncementRepositoryBridge(ref.read(announcementsFirestoreProvider));
});

final getAnnouncementsUseCaseProvider = Provider((ref) => GetAnnouncementsUseCase(ref.read(announcementRepositoryProvider)));
final getAnnouncementDetailUseCaseProvider = Provider((ref) => GetAnnouncementDetailUseCase(ref.read(announcementRepositoryProvider)));
final createAnnouncementUseCaseProvider = Provider((ref) => CreateAnnouncementUseCase(ref.read(announcementRepositoryProvider)));
final sendAnnouncementNotificationUseCaseProvider = Provider((ref) => SendAnnouncementNotificationUseCase(ref.read(announcementRepositoryProvider)));

final announcementsNotifierProvider = StateNotifierProvider<AnnouncementNotifier, AnnouncementsState>((ref) {
  return AnnouncementNotifier(
    getAnnouncements: ref.read(getAnnouncementsUseCaseProvider),
    getAnnouncementDetail: ref.read(getAnnouncementDetailUseCaseProvider),
    createAnnouncement: ref.read(createAnnouncementUseCaseProvider),
    sendAnnouncementNotification: ref.read(sendAnnouncementNotificationUseCaseProvider),
  );
});
