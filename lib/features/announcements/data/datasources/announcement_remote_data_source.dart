import '../models/announcement_model.dart';

abstract class AnnouncementRemoteDataSource {
  Future<List<AnnouncementModel>> getAnnouncements();
  Future<AnnouncementModel> getAnnouncementDetail(String id);
  Future<void> createAnnouncement(AnnouncementModel announcement);
}
