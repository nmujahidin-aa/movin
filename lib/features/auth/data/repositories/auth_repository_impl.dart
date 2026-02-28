import 'package:movin/features/auth/domain/entities/user.dart';
import 'package:movin/features/auth/domain/usecase/register_usecase.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecase/login_usecase.dart';
import '../datasource/auth_remote_datasource.dart';
import '../datasource/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource local;

  AuthRepositoryImpl(this.remoteDataSource, this.local);

  @override
  Future<AuthSession> login(LoginParams params) async {
    final response = await remoteDataSource.login(params);
    await local.saveToken(response.token);
    return response.toEntity();
  }

  @override
  Future<AuthSession> register(RegisterParams params) async {
    final response = await remoteDataSource.register(params);
    await local.saveToken(response.token);
    return response.toEntity();
  }

  @override
  Future<User?> getCurrentUser() async {
    final userModel = await remoteDataSource.getCurrentUser();
    return userModel?.toEntity();
  }

  @override
  Future<AuthSession?> getSavedSession() async {
    final token = await local.getToken();
    print("TOKEN FROM LOCAL: $token");

    if (token == null || token.isEmpty) {
      return null;
    }

    try {
      final userModel = await remoteDataSource.getCurrentUser();
      if (userModel == null) return null;
      return AuthSession(
        token: token,
        user: userModel.toEntity(),
      );
    } catch (_) {
      await local.clearToken();
      return null;
    }
  }


  @override
  Future<void> logout() async {
    await local.clearToken();
    await remoteDataSource.logout();
  }
}
