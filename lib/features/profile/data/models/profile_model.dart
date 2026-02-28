import 'package:movin/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required int id,
    required String name,
    required String email,
    String? phone,
  }) : super(id: id, name: name, email: email, phone: phone);
 
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone_number'],
    );
  }

  Profile toEntity() {
    return Profile(
      id: id,
      name: name,
      email: email,
      phone: phone,
    );
  }
}