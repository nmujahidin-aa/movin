import 'package:dio/dio.dart';
import 'package:movin/features/auth/data/models/auth_response_model.dart';
import 'package:movin/features/auth/domain/usecase/login_usecase.dart';
import 'package:movin/features/auth/domain/usecase/register_usecase.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class AuthRemoteDataSource {
  final Dio dio;
  final baseUrl = dotenv.env['BASE_URL'] ?? '';

  AuthRemoteDataSource(this.dio);

  Future<AuthResponseModel> login(LoginParams params) async {
    try {
      final response = await dio.post(
        '/login',
        data: {
          "email": params.email,
          "password": params.password,
        },
      );

      return AuthResponseModel.fromJson(response.data);

    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<AuthResponseModel> register(RegisterParams params) async {
    try {
      final response = await dio.post(
      '/register',
      data: {
        "name": params.name,
        "email": params.email,
        "password": params.password,
        "c_password": params.confirmPassword,
        "role": "user",
        "phone_number": "",
      },
    );

    return AuthResponseModel.fromJson(response.data);

    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final response = await dio.get('/me');
      return UserModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await dio.get('/logout');
  }
}

String _handleDioError(DioException e) {
  final statusCode = e.response?.statusCode;
  final data = e.response?.data;

  if (statusCode == 404 && data is Map && data['message'] == 'Unauthorised.') {
    return "Email atau password salah.";
  } else if (statusCode == 404 && data is Map && data['message'] == 'Email telah terpakai, silahkan ganti dengan email yang lain') {
    return "Email telah terpakai, silahkan ganti dengan email yang lain.";
  }

  switch (statusCode) {
    case 400:
      return "Permintaan tidak valid.";
    case 401:
      return "Tidak memiliki akses.";
    case 404:
      return "Endpoint tidak ditemukan.";
    case 500:
      return "Terjadi kesalahan di server.";
    default:
      return "Terjadi kesalahan jaringan.";
  }
}
