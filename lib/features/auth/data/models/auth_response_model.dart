import '../../domain/entities/auth_session.dart';
import '../../domain/entities/user.dart';

class AuthResponseModel {
  final String token;
  final String name;
  final String email;

  AuthResponseModel({
    required this.token,
    required this.name,
    required this.email,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['data']['token'],
      name: json['data']['name'],
      email: json['data']['email'],
    );
  }

  AuthSession toEntity() {
    return AuthSession(
      token: token,
      user: User(
        name: name,
        email: email,
      ),
    );
  }
}
