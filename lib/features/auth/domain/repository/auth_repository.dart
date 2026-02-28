import 'package:movin/features/auth/domain/entities/auth_session.dart';

import '../entities/user.dart';
import '../usecase/login_usecase.dart';
import '../usecase/register_usecase.dart';

abstract class AuthRepository {
  Future<AuthSession> login(LoginParams params);
  Future<AuthSession> register(RegisterParams params);
  
  Future<AuthSession?> getSavedSession();
  Future<void> logout();
  Future<User?> getCurrentUser();
}

