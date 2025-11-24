import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/GetUserUseCase.dart';
import '../../domain/usecases/LoginUseCase.dart';
import '../../domain/usecases/RegisterUseCase.dart';
import '../../core/errors/failure.dart';
import 'membership_state.dart';

class MembershipNotifier extends StateNotifier<MembershipState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  MembershipNotifier({
    required this.getUserProfileUseCase,
    required this.loginUseCase,
    required this.registerUseCase,
  }) : super(const MembershipState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: MembershipStatus.loading, errorMessage: null);
    final Either<Failure, User> result = await loginUseCase.call(email, password);
    result.fold((failure) {
      state = state.copyWith(status: MembershipStatus.error, errorMessage: failure.message);
    }, (user) {
      state = state.copyWith(status: MembershipStatus.authenticated, currentUser: user, errorMessage: null);
    });
  }

  Future<void> register(String email, String password, UserRole role) async {
    state = state.copyWith(status: MembershipStatus.loading, errorMessage: null);
    final Either<Failure, User> result = await registerUseCase.call(email, password, role);
    result.fold((failure) {
      state = state.copyWith(status: MembershipStatus.error, errorMessage: failure.message);
    }, (user) {
      state = state.copyWith(status: MembershipStatus.authenticated, currentUser: user, errorMessage: null);
    });
  }

  Future<void> loadProfile(String id) async {
    state = state.copyWith(status: MembershipStatus.loading, errorMessage: null);
    final Either<Failure, User> result = await getUserProfileUseCase.call(id);
    result.fold((failure) {
      state = state.copyWith(status: MembershipStatus.error, errorMessage: failure.message);
    }, (user) {
      state = state.copyWith(status: MembershipStatus.authenticated, currentUser: user, errorMessage: null);
    });
  }
}
