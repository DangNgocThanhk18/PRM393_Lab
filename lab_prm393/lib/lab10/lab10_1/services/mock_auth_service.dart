// lib/services/mock_auth_service.dart
import 'dart:async';
import '../models/user.dart';

class MockAuthService {
  // Mock valid credentials
  final Map<String, String> _validCredentials = {
    'user@example.com': 'password123',
    'test@test.com': 'test123',
  };

  Future<User> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Validate credentials
    if (_validCredentials.containsKey(email) &&
        _validCredentials[email] == password) {
      return User(
        email: email,
        token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      );
    } else {
      throw Exception('Invalid email or password');
    }
  }
}