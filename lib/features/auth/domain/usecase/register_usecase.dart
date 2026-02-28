import '../entities/auth_session.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<AuthSession> call(RegisterParams params) {
    return repository.register(params);
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password, 
    required this.confirmPassword,
  });
}
