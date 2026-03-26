// lib/models/user.dart
class User {
  final int id;
  final String username;
  final String email;
  final String token;
  final String firstName;
  final String lastName;
  final String? photoUrl;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
    required this.firstName,
    required this.lastName,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'token': token,
    'firstName': firstName,
    'lastName': lastName,
    'photoUrl': photoUrl,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    username: json['username'],
    email: json['email'],
    token: json['token'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    photoUrl: json['photoUrl'],
  );
}