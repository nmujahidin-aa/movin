import 'user.dart';

class AuthSession {
  final String token;
  final User? user;

  const AuthSession({
    required this.token,
    this.user,
  });
}
