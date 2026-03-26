// lib/models/user.dart
class User {
  final int id;
  final String username;
  final String email;
  final String token;
  final String firstName;
  final String lastName;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
    required this.firstName,
    required this.lastName,
  });
}