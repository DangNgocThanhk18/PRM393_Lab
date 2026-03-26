// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

final authServiceProvider = Provider((ref) => AuthService());
final storageServiceProvider = Provider((ref) => StorageService());

final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
      (ref) => AuthNotifier(
    ref.watch(authServiceProvider),
    ref.watch(storageServiceProvider),
  ),
);

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthService _authService;
  final StorageService _storageService;

  AuthNotifier(this._authService, this._storageService)
      : super(const AsyncValue.loading()) {
    _checkAutoLogin();
  }

  Future<void> _checkAutoLogin() async {
    final user = await _storageService.getUser();
    if (user != null) {
      state = AsyncValue.data(user);
    } else {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();

    try {
      final user = await _authService.login(username, password);
      await _storageService.saveUser(user);
      state = AsyncValue.data(user);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  Future<void> logout() async {
    await _storageService.clearUser();
    state = const AsyncValue.data(null);
  }
}