import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';

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
  final firebase.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthNotifier(this._authService, this._firebaseAuth, this._googleSignIn)
      : super(const AuthState()) {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser != null && state.user?.authType != 'google') {
        final user = User.fromFirebaseUser(firebaseUser);
        state = state.copyWith(user: user);
        _authService.saveSession(user);
      } else if (firebaseUser == null && state.user?.authType == 'google') {
        state = state.copyWith(user: null);
      }
    });
  }

  Future<void> checkAutoLogin() async {
    state = state.copyWith(isCheckingSession: true);

    // Check local session first
    final localUser = await _authService.getSession();

    if (localUser != null) {
      state = state.copyWith(user: localUser, isCheckingSession: false);
      // Send welcome back notification
      await NotificationService.showWelcomeBackNotification(localUser.fullName);
    } else {
      state = state.copyWith(isCheckingSession: false);
    }
  }

  Future<bool> apiLogin(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _authService.apiLogin(username, password);
      final user = User.fromApiJson(response);
      await _authService.saveSession(user);
      state = state.copyWith(user: user, isLoading: false);

      // Send login success notification
      await NotificationService.showLoginSuccessNotification(username);

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }

  Future<void> googleSignIn() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = firebase.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final firebaseUser = await _firebaseAuth.signInWithCredential(credential);
      final user = User.fromFirebaseUser(firebaseUser.user!);
      await _authService.saveSession(user);
      state = state.copyWith(user: user, isLoading: false);

      // Send Google login success notification
      await NotificationService.showGoogleLoginSuccessNotification(user.fullName);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    // Sign out from Firebase if Google login
    if (state.user?.authType == 'google') {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    }

    await _authService.clearSession();
    state = const AuthState();

    // Send logout notification
    await NotificationService.showLogoutNotification();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    AuthService(),
    firebase.FirebaseAuth.instance,
    GoogleSignIn(),
  );
});