import 'package:dio/dio.dart';
import 'package:movin/features/profile/data/models/profile_model.dart';

class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource(this.dio);

  Future<ProfileModel> getProfile() async {
    final response = await dio.get('/me');
    return ProfileModel.fromJson(response.data['data']);
  }

  Future<ProfileModel> updateProfile({
    required int id,
    required String name,
    required String email,
    String? password,
    String? confirmPassword,
    String? phone,
  }) async {
    final response = await dio.post(
      '/update-user/$id',
      data: {
        "name": name,
        "email": email,
        "password": password,
        "c_password": confirmPassword,
        "phone_number": phone,
      },
    );

    return ProfileModel.fromJson(response.data['data']);
  }
}