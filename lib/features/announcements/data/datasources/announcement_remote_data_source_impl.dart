import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/announcement_model.dart';
import 'announcement_remote_data_source.dart';

class AnnouncementRemoteDataSourceImpl implements AnnouncementRemoteDataSource {
  final FirebaseFirestore firestore;

  AnnouncementRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<AnnouncementModel>> getAnnouncements() async {
    final snapshot = await firestore.collection('announcements').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return AnnouncementModel.fromJson({
        'id': doc.id,
        ...data,
      });
    }).toList();
  }

  @override
  Future<AnnouncementModel> getAnnouncementDetail(String id) async {
    final doc = await firestore.collection('announcements').doc(id).get();
    final data = doc.data();
    if (data == null) throw Exception('Announcement not found');
    return AnnouncementModel.fromJson({'id': doc.id, ...data});
  }

  @override
  Future<void> createAnnouncement(AnnouncementModel announcement) async {
    await firestore.collection('announcements').add(announcement.toJson());
  }
}
