class User {
  final int? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? token;
  final String? photoUrl;
  final String? displayName;
  final String? authType; // 'api' or 'google'

  const User({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.token,
    this.photoUrl,
    this.displayName,
    this.authType,
  });

  factory User.fromApiJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      token: json['accessToken'],
      authType: 'api',
    );
  }

  factory User.fromFirebaseUser(firebase.User user) {
    return User(
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      token: user.uid,
      authType: 'google',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'token': token,
      'photoUrl': photoUrl,
      'displayName': displayName,
      'authType': authType,
    };
  }

  String get fullName {
    if (authType == 'google' && displayName != null) {
      return displayName!;
    }
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return username ?? email ?? 'User';
  }
}