import 'package:movin/features/profile/domain/entities/profile.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState {
  final ProfileStatus status;
  final Profile? profile;
  final String? message;

  ProfileState({
    required this.status,
    this.profile,
    this.message,
  });

  factory ProfileState.initial() =>
      ProfileState(status: ProfileStatus.initial);

  ProfileState copyWith({
    ProfileStatus? status,
    Profile? profile,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      message: message,
    );
  }
}