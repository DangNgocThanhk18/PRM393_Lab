import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isCheckingSession;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isCheckingSession = false,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? isCheckingSession,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isCheckingSession: isCheckingSession ?? this.isCheckingSession,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AuthState());

  Future<void> checkAutoLogin() async {
    state = state.copyWith(isCheckingSession: true);

    final user = await _authService.getSession();

    if (user != null) {
      state = state.copyWith(user: user, isCheckingSession: false);
    } else {
      state = state.copyWith(isCheckingSession: false);
    }
  }

  Future<bool> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _authService.login(username, password);
      final user = User.fromJson(response);
      await _authService.saveSession(user);
      state = state.copyWith(user: user, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.clearSession();
    state = const AuthState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthService());
});