import '../../domain/entities/user.dart';

class UserModel {
  final String name;
  final String email;

  UserModel({
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['data']['name'],
      email: json['data']['email'],
    );
  }

  User toEntity() {
    return User(
      name: name,
      email: email,
    );
  }
}
