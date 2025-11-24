import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/errors/failure.dart';
import '../../domain/entities/announcement_entity.dart';
import '../../domain/repositories/announcement_repository.dart';

class AnnouncementRepositoryBridge implements AnnouncementRepository {
  final FirebaseFirestore firestore;

  AnnouncementRepositoryBridge(this.firestore);

  CollectionReference get _announcements => firestore.collection('announcements');

  Announcement _mapDocToAnnouncement(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Announcement(
      id: doc.id,
      title: data['title'] as String? ?? '',
      message: data['message'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  @override
  Future<Either<Failure, void>> createAnnouncement(Announcement announcement) async {
    try {
      final map = {
        'title': announcement.title,
        'message': announcement.message,
        'createdAt': FieldValue.serverTimestamp(),
      };
      await _announcements.doc(announcement.id).set(map);
      return const Right(null);
    } catch (e) {
      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Announcement>> getAnnouncementDetail(String id) async {
    try {
      final doc = await _announcements.doc(id).get();
      if (!doc.exists) return Left(SimpleFailure('Announcement not found'));
      return Right(_mapDocToAnnouncement(doc));
    } catch (e) {
      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Announcement>>> getAnnouncements() async {
    try {
      final snap = await _announcements.orderBy('createdAt', descending: true).get();
      final list = snap.docs.map(_mapDocToAnnouncement).toList();
      return Right(list);
    } catch (e) {
      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendAnnouncementNotification(Announcement announcement) async {
    try {
      // For now, just store a copy/flag in Firestore to indicate notification was sent.
      await _announcements.doc(announcement.id).set({
        'title': announcement.title,
        'message': announcement.message,
        'createdAt': announcement.createdAt,
        'notifiedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return const Right(null);
    } catch (e) {
      return Left(SimpleFailure(e.toString()));
    }
  }
}
