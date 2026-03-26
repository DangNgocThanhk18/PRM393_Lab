import 'dart:async';
import '../models/user.dart';

/// Repository that simulates fetching user data from an API
class UserRepository {
  /// Simulates an API call that returns JSON data
  Future<List<Map<String, dynamic>>> _fetchUsersFromAPI() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Simulated JSON response from API
    return [
      {'name': 'Alice Johnson', 'email': 'alice@example.com'},
      {'name': 'Bob Smith', 'email': 'bob@example.com'},
      {'name': 'Charlie Brown', 'email': 'charlie@example.com'},
      {'name': 'Diana Prince', 'email': 'diana@example.com'},
    ];
  }

  /// Fetches users and parses them into User objects
  Future<List<User>> getUsers() async {
    print('  🌐 Fetching users from API...');
    final jsonData = await _fetchUsersFromAPI();

    print('  📦 Parsing JSON data to User objects...');
    final users = jsonData.map((json) => User.fromJson(json)).toList();

    return users;
  }
}