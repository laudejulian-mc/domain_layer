import 'package:equatable/equatable.dart';

class ClubInfo extends Equatable {
  final String id;
  final String name;
  final String mission;
  final String history;
  final String contactInfo;
  final List<String> rules;

  const ClubInfo({
    required this.id,
    required this.name,
    required this.mission,
    required this.history,
    required this.contactInfo,
    required this.rules,
  });

  @override
  List<Object?> get props => [id, name, mission, history, contactInfo, rules];
}
