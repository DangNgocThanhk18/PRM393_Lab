/// User model with JSON serialization support
class User {
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  /// Factory constructor to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  /// Convert User to JSON (for completeness)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() => 'User(name: $name, email: $email)';
}