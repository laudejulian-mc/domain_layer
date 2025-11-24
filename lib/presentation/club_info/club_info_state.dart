import 'package:equatable/equatable.dart';
import '../../domain/entities/club_info.dart';

enum ClubInfoStatus { initial, loading, loaded, error }

class ClubInfoState extends Equatable {
  final ClubInfoStatus status;
  final ClubInfo? clubInfo;
  final String? errorMessage;

  const ClubInfoState({
    this.status = ClubInfoStatus.initial,
    this.clubInfo,
    this.errorMessage,
  });

  ClubInfoState copyWith({
    ClubInfoStatus? status,
    ClubInfo? clubInfo,
    String? errorMessage,
  }) {
    return ClubInfoState(
      status: status ?? this.status,
      clubInfo: clubInfo ?? this.clubInfo,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, clubInfo, errorMessage];
}
