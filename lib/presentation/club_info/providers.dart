import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/datasources/club_info_remote_data_source_impl.dart';
import '../../data/repositories/club_info_repository_impl.dart';
import '../../domain/usecases/get_club_info.dart';
import 'club_info_notifier.dart';
import 'club_info_state.dart';

final clubInfoFirestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final clubInfoRemoteDataSourceProvider = Provider((ref) {
  return ClubInfoRemoteDataSourceImpl(firestore: ref.read(clubInfoFirestoreProvider));
});

final clubInfoRepositoryProvider = Provider((ref) {
  return ClubInfoRepositoryImpl(ref.read(clubInfoRemoteDataSourceProvider));
});

final getClubInfoUseCaseProvider = Provider((ref) => GetClubInfo(ref.read(clubInfoRepositoryProvider)));

final clubInfoNotifierProvider = StateNotifierProvider<ClubInfoNotifier, ClubInfoState>((ref) {
  return ClubInfoNotifier(getClubInfo: ref.read(getClubInfoUseCaseProvider));
});
