import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../features/auth/data/datasource/auth_local_datasource.dart';

class DioClient {
  late final Dio dio;

  DioClient(AuthLocalDataSource local) {
    dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL']!,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await local.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );
  }
}
