class Profile {
  final int id;
  final String name;
  final String email;
  final String? phone;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
  });
}