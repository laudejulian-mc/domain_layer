import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

enum MembershipStatus { initial, loading, authenticated, unauthenticated, error }

class MembershipState extends Equatable {
  final MembershipStatus status;
  final User? currentUser;
  final String? errorMessage;

  const MembershipState({
    this.status = MembershipStatus.initial,
    this.currentUser,
    this.errorMessage,
  });

  MembershipState copyWith({
    MembershipStatus? status,
    User? currentUser,
    String? errorMessage,
  }) {
    return MembershipState(
      status: status ?? this.status,
      currentUser: currentUser ?? this.currentUser,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, currentUser, errorMessage];
}
