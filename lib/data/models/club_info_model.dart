import '../../domain/entities/club_info.dart';

class ClubInfoModel extends ClubInfo {
  const ClubInfoModel({
    required super.id,
    required super.name,
    required super.mission,
    required super.history,
    required super.contactInfo,
    required super.rules,
  });

  factory ClubInfoModel.fromJson(Map<String, dynamic> json) {
    return ClubInfoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      mission: json['mission'] as String,
      history: json['history'] as String,
      contactInfo: json['contactInfo'] as String,
      rules: List<String>.from(json['rules'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mission': mission,
      'history': history,
      'contactInfo': contactInfo,
      'rules': rules,
    };
  }
}
