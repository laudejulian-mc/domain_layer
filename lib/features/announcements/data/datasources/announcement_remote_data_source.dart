import '../models/announcement_model.dart';

abstract class AnnouncementRemoteDataSource {
  Future<List<AnnouncementModel>> getAnnouncements();
  Future<void> createAnnouncement(AnnouncementModel model);
  Future<void> deleteAnnouncement(String id);
}
