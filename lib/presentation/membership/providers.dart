import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/datasources/user_remote_data_source_impl.dart';
import '../../data/datasources/user_remote_data_source.dart';
import '../../data/repositories/user_repository_bridge.dart';
import '../../domain/usecases/GetUserUseCase.dart';
import '../../domain/usecases/LoginUseCase.dart';
import '../../domain/usecases/RegisterUseCase.dart';
import '../membership/membership_notifier.dart';
import 'membership_state.dart';

// Firebase instances
final firebaseAuthProvider = Provider<fb_auth.FirebaseAuth>((ref) {
  return fb_auth.FirebaseAuth.instance;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// Data source
final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  return UserRemoteDataSourceImpl(
    firebaseAuth: ref.read(firebaseAuthProvider),
    firestore: ref.read(firestoreProvider),
  );
});

// Repository bridge adapting data source to domain repository interface
final userRepositoryProvider = Provider((ref) {
  return UserRepositoryBridge(ref.read(userRemoteDataSourceProvider));
});

// Usecases
final getUserProfileUseCaseProvider = Provider((ref) {
  return GetUserProfileUseCase(ref.read(userRepositoryProvider));
});

final loginUseCaseProvider = Provider((ref) {
  return LoginUseCase(ref.read(userRepositoryProvider));
});

final registerUseCaseProvider = Provider((ref) {
  return RegisterUseCase(ref.read(userRepositoryProvider));
});

// StateNotifier provider
final membershipNotifierProvider = StateNotifierProvider<MembershipNotifier, MembershipState>((ref) {
  return MembershipNotifier(
    getUserProfileUseCase: ref.read(getUserProfileUseCaseProvider),
    loginUseCase: ref.read(loginUseCaseProvider),
    registerUseCase: ref.read(registerUseCaseProvider),
  );
});
