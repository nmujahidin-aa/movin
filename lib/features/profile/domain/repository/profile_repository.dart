import 'package:movin/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
  Future<Profile> updateProfile({
    required int id,
    required String name,
    required String email,
    String? phone,
    String? password,
    String? confirmPassword,
  });
}