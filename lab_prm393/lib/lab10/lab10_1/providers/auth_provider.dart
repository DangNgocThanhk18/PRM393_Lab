// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/mock_auth_service.dart';

final authServiceProvider = Provider((ref) => MockAuthService());

final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
      (ref) => AuthNotifier(ref.watch(authServiceProvider)),
);

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final MockAuthService _authService;

  AuthNotifier(this._authService) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final user = await _authService.login(email, password);
      state = AsyncValue.data(user);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  void logout() {
    state = const AsyncValue.data(null);
  }
}