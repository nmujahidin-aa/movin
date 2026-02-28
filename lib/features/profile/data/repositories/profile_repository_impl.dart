import 'package:movin/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:movin/features/profile/domain/entities/profile.dart';
import 'package:movin/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  Future<Profile> getProfile() async {
    final model = await remote.getProfile();
    return model.toEntity();
  }

  @override
  Future<Profile> updateProfile({
    required int id,
    required String name,
    required String email,
    String? password,
    String? confirmPassword,
    String? phone,
  }) async {
    final model = await remote.updateProfile(
      id: id,
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
    );

    return model.toEntity();
  }
}