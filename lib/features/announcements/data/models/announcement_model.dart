import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/announcement.dart';

/// Data Transfer Object extending the domain entity
class AnnouncementModel extends Announcement {
  AnnouncementModel({
    required String id,
    required String title,
    required String message,
    String? imageUrl,
    String? linkUrl,
    required DateTime createdAt,
    required String createdBy,
  }) : super(
          id: id,
          title: title,
          message: message,
          imageUrl: imageUrl,
          linkUrl: linkUrl,
          createdAt: createdAt,
          createdBy: createdBy,
        );

  /// Convert Firestore document → model
  factory AnnouncementModel.fromMap(Map<String, dynamic> map, String id) {
    return AnnouncementModel(
      id: id,
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      imageUrl: map['imageUrl'],
      linkUrl: map['linkUrl'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdBy: map['createdBy'] ?? '',
    );
  }

  /// Convert Firestore DocumentSnapshot → model
  factory AnnouncementModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AnnouncementModel.fromMap(data, doc.id);
  }

  /// Convert model → Firestore map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'imageUrl': imageUrl,
      'linkUrl': linkUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
    };
  }
}
