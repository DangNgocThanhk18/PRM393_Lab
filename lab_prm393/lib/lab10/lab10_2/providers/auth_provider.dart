// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/api_auth_service.dart';

final authServiceProvider = Provider((ref) => ApiAuthService());

final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
      (ref) => AuthNotifier(ref.watch(authServiceProvider)),
);

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final ApiAuthService _authService;

  AuthNotifier(this._authService) : super(const AsyncValue.data(null));

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();

    try {
      final user = await _authService.login(username, password);
      state = AsyncValue.data(user);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  void logout() {
    state = const AsyncValue.data(null);
  }
}