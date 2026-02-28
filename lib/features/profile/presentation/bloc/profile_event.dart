abstract class ProfileEvent {}

class ProfileRequested extends ProfileEvent {}

class ProfileUpdateRequested extends ProfileEvent {
  final int id;
  final String name;
  final String email;
  final String? password;
  final String? confirmPassword;
  final String? phone;

  ProfileUpdateRequested({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.confirmPassword,
    this.phone,
  });
}