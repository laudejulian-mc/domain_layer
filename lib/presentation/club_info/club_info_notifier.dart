import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';

import '../../domain/usecases/get_club_info.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/club_info.dart';
import 'club_info_state.dart';

class ClubInfoNotifier extends StateNotifier<ClubInfoState> {
  final GetClubInfo getClubInfo;

  ClubInfoNotifier({required this.getClubInfo}) : super(const ClubInfoState());

  Future<void> loadClubInfo() async {
    state = state.copyWith(status: ClubInfoStatus.loading, errorMessage: null);
    final Either<Failure, ClubInfo> res = await getClubInfo.call();
    res.fold((failure) {
      state = state.copyWith(status: ClubInfoStatus.error, errorMessage: failure.message);
    }, (clubInfo) {
      state = state.copyWith(status: ClubInfoStatus.loaded, clubInfo: clubInfo, errorMessage: null);
    });
  }

  /// Update club info locally (UI-level). Persistence not implemented in repository.
  Future<void> updateClubInfo(ClubInfo updated) async {
    // Here we simply update the state; persistence should be implemented in data layer and usecase.
    state = state.copyWith(status: ClubInfoStatus.loading, errorMessage: null);
    // Simulate immediate success
    state = state.copyWith(status: ClubInfoStatus.loaded, clubInfo: updated, errorMessage: null);
  }
}
