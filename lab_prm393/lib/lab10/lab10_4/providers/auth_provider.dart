// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// // Provider cho Firebase Auth instance
// final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
//
// // Provider cho Google Sign-In (chỉ dùng mobile)
// final googleSignInProvider = Provider((ref) => GoogleSignIn());
//
// // StreamProvider để theo dõi trạng thái đăng nhập
// final authStateProvider = StreamProvider<User?>((ref) {
//   final auth = ref.watch(firebaseAuthProvider);
//   return auth.authStateChanges();
// });
//
// // StateNotifierProvider để thực hiện các action
// final authNotifierProvider =
// StateNotifierProvider<AuthNotifier, AsyncValue<void>>(
//       (ref) => AuthNotifier(
//     ref.watch(firebaseAuthProvider),
//     ref.watch(googleSignInProvider),
//   ),
// );
//
// class AuthNotifier extends StateNotifier<AsyncValue<void>> {
//   final FirebaseAuth _auth;
//   final GoogleSignIn _googleSignIn;
//
//   AuthNotifier(this._auth, this._googleSignIn)
//       : super(const AsyncValue.data(null));
//
//   // ✅ SIGN IN GOOGLE (fix cho Web + Mobile)
//   Future<void> signInWithGoogle() async {
//     try {
//       state = const AsyncValue.loading();
//
//       if (kIsWeb) {
//         // 🌐 Flutter Web
//         final provider = GoogleAuthProvider();
//         provider.addScope('email');
//
//         await _auth.signInWithPopup(provider);
//       } else {
//         // 📱 Android / iOS
//         final GoogleSignInAccount? googleUser =
//         await _googleSignIn.signIn();
//
//         if (googleUser == null) {
//           state = const AsyncValue.data(null);
//           return;
//         }
//
//         final googleAuth = await googleUser.authentication;
//
//         final credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );
//
//         await _auth.signInWithCredential(credential);
//       }
//
//       state = const AsyncValue.data(null);
//     } on FirebaseAuthException catch (e) {
//       state = AsyncValue.error(
//         e.message ?? 'Authentication failed',
//         StackTrace.current,
//       );
//     } catch (e) {
//       state = AsyncValue.error(e.toString(), StackTrace.current);
//     }
//   }
//
//   // ✅ SIGN OUT (fix luôn cho Web)
//   Future<void> signOut() async {
//     try {
//       state = const AsyncValue.loading();
//
//       if (!kIsWeb) {
//         await _googleSignIn.signOut();
//       }
//
//       await _auth.signOut();
//
//       state = const AsyncValue.data(null);
//     } catch (e) {
//       state = AsyncValue.error(e.toString(), StackTrace.current);
//     }
//   }
// }