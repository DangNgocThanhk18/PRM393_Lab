// // lib/services/storage_service.dart
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../models/user.dart';
//
// class StorageService {
//   static const String _keyUser = 'user';
//   static const String _keyToken = 'token';
//   static const String _keyAuthMethod = 'auth_method';
//
//   Future<void> saveUser(User user, {String authMethod = 'api'}) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUser, json.encode(user.toJson()));
//     await prefs.setString(_keyToken, user.token);
//     await prefs.setString(_keyAuthMethod, authMethod);
//   }
//
//   Future<User?> getUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userJson = prefs.getString(_keyUser);
//     if (userJson != null) {
//       return User.fromJson(json.decode(userJson));
//     }
//     return null;
//   }
//
//   Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyToken);
//   }
//
//   Future<String?> getAuthMethod() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyAuthMethod);
//   }
//
//   Future<void> clearUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyUser);
//     await prefs.remove(_keyToken);
//     await prefs.remove(_keyAuthMethod);
//   }
// }