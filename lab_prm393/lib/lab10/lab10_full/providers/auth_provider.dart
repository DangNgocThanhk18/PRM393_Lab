// // lib/providers/auth_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../models/user.dart';
// import '../services/api_auth_service.dart';
// import '../services/storage_service.dart';
// import 'notification_provider.dart';
//
// final apiAuthServiceProvider = Provider((ref) => ApiAuthService());
// final storageServiceProvider = Provider((ref) => StorageService());
// final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
// final googleSignInProvider = Provider((ref) => GoogleSignIn());
//
// final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
//       (ref) => AuthNotifier(
//     ref.watch(apiAuthServiceProvider),
//     ref.watch(storageServiceProvider),
//     ref.watch(firebaseAuthProvider),
//     ref.watch(googleSignInProvider),
//     ref.watch(notificationProvider),
//   ),
// );
//
// class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
//   final ApiAuthService _apiAuthService;
//   final StorageService _storageService;
//   final FirebaseAuth _firebaseAuth;
//   final GoogleSignIn _googleSignIn;
//   final NotificationService _notificationService;
//
//   AuthNotifier(
//       this._apiAuthService,
//       this._storageService,
//       this._firebaseAuth,
//       this._googleSignIn,
//       this._notificationService,
//       ) : super(const AsyncValue.loading()) {
//     _checkAutoLogin();
//     _listenToFirebaseAuth();
//   }
//
//   void _listenToFirebaseAuth() {
//     _firebaseAuth.authStateChanges().listen((firebaseUser) async {
//       if (firebaseUser != null) {
//         // Convert Firebase user to app User model
//         final user = User(
//           id: 0,
//           username: firebaseUser.displayName ?? firebaseUser.email?.split('@').first ?? 'user',
//           email: firebaseUser.email ?? '',
//           token: await firebaseUser.getIdToken() ?? '',
//           firstName: firebaseUser.displayName?.split(' ').first ?? '',
//           lastName: firebaseUser.displayName?.split(' ').last ?? '',
//           photoUrl: firebaseUser.photoURL,
//         );
//         await _storageService.saveUser(user, authMethod: 'google');
//         state = AsyncValue.data(user);
//
//         // Send notification on successful login
//         await _notificationService.showNotification(
//           id: DateTime.now().millisecond,
//           title: 'Welcome!',
//           body: 'Successfully logged in with Google',
//           payload: 'google_login',
//         );
//       }
//     });
//   }
//
//   Future<void> _checkAutoLogin() async {
//     final user = await _storageService.getUser();
//     if (user != null) {
//       state = AsyncValue.data(user);
//     } else {
//       state = const AsyncValue.data(null);
//     }
//   }
//
//   Future<void> loginWithApi(String username, String password) async {
//     state = const AsyncValue.loading();
//
//     try {
//       final user = await _apiAuthService.login(username, password);
//       await _storageService.saveUser(user, authMethod: 'api');
//       state = AsyncValue.data(user);
//
//       // Send notification on successful login
//       await _notificationService.showNotification(
//         id: DateTime.now().millisecond,
//         title: 'Welcome ${user.firstName}!',
//         body: 'Successfully logged in to your account',
//         payload: 'api_login',
//       );
//     } catch (error) {
//       state = AsyncValue.error(error, StackTrace.current);
//     }
//   }
//
//   Future<void> loginWithGoogle() async {
//     state = const AsyncValue.loading();
//
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//
//       if (googleUser == null) {
//         state = const AsyncValue.data(null);
//         return;
//       }
//
//       final GoogleSignInAuthentication googleAuth =
//       await googleUser.authentication;
//
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       await _firebaseAuth.signInWithCredential(credential);
//       // State will be updated by _listenToFirebaseAuth
//     } catch (error) {
//       state = AsyncValue.error(error, StackTrace.current);
//     }
//   }
//
//   Future<void> logout() async {
//     final authMethod = await _storageService.getAuthMethod();
//
//     if (authMethod == 'google') {
//       await _googleSignIn.signOut();
//       await _firebaseAuth.signOut();
//     }
//
//     await _storageService.clearUser();
//     state = const AsyncValue.data(null);
//
//     // Send notification on logout
//     await _notificationService.showNotification(
//       id: DateTime.now().millisecond,
//       title: 'Goodbye!',
//       body: 'You have been logged out successfully',
//       payload: 'logout',
//     );
//   }
// }