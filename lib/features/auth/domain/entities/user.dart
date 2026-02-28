class User {
  final String name;
  final String email;
  final String? phoneNumber;

  const User({
    required this.name,
    required this.email,
    this.phoneNumber,
  });
}
