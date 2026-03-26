// // lib/screens/auth_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/auth_provider.dart';
//
// class AuthScreen extends ConsumerWidget {
//   const AuthScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authStateProvider);
//     final authNotifier = ref.watch(authNotifierProvider.notifier);
//     final signInState = ref.watch(authNotifierProvider);
//
//     return authState.when(
//       data: (user) {
//         if (user != null) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             Navigator.pushReplacementNamed(context, '/home');
//           });
//         }
//         return _buildSignInScreen(context, authNotifier, signInState);
//       },
//       error: (error, stack) => Scaffold(
//         body: Center(
//           child: Text('Error: $error'),
//         ),
//       ),
//       loading: () => const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSignInScreen(
//       BuildContext context,
//       AuthNotifier authNotifier,
//       AsyncValue<void> signInState,
//       ) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const FlutterLogo(size: 100),
//               const SizedBox(height: 32),
//               const Text(
//                 'Welcome',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Sign in to continue',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 48),
//               ElevatedButton.icon(
//                 onPressed: signInState.isLoading
//                     ? null
//                     : () async {
//                   await authNotifier.signInWithGoogle();
//                 },
//                 icon: Image.asset(
//                   'assets/google_logo.png',
//                   height: 24,
//                   width: 24,
//                 ),
//                 label: const Text('Sign in with Google'),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                   elevation: 2,
//                 ),
//               ),
//               if (signInState.isLoading)
//                 const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Center(child: CircularProgressIndicator()),
//                 ),
//               if (signInState.hasError)
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     'Error: ${signInState.error}',
//                     style: const TextStyle(color: Colors.red),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }