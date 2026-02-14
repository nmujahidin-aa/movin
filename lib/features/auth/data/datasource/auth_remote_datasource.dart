import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final Dio dio = DioClient.dio;

  Future<UserModel> login(String email, String password) async {
    final response = await dio.post(
      '/login',
      data: {
        "email": email,
        "password": password,
      },
    );

    return UserModel.fromJson(response.data);
  }

  Future<UserModel> register(
      String name, String email, String password) async {
    final response = await dio.post(
      '/register',
      data: {
        "name": name,
        "email": email,
        "password": password,
        "c_password": password,
      },
    );

    return UserModel.fromJson(response.data);
  }
}
