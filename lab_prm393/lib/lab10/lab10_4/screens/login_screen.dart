// // lib/screens/login_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/auth_provider.dart';
//
// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final authState = ref.watch(authStateProvider);
//     final signInState = ref.watch(authNotifierProvider);
//     final authNotifier = ref.read(authNotifierProvider.notifier);
//
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
//                 'Google Sign-In',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Sign in with your Google account',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 48),
//
//               // Nút đăng nhập Google
//               ElevatedButton.icon(
//                 onPressed: signInState.isLoading
//                     ? null
//                     : () async {
//                   await authNotifier.signInWithGoogle();
//                 },
//                 icon: const Icon(Icons.login),
//                 label: const Text(
//                   'Sign in with Google',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     side: BorderSide(color: Colors.grey.shade300),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               // Hiển thị loading indicator
//               if (signInState.isLoading)
//                 const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Center(child: CircularProgressIndicator()),
//                 ),
//
//               // Hiển thị lỗi nếu có
//               if (signInState.hasError)
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade50,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.red.shade200),
//                   ),
//                   child: Text(
//                     'Error: ${signInState.error}',
//                     style: TextStyle(color: Colors.red.shade700),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//
//               // Theo dõi auth state để chuyển màn hình
//               authState.when(
//                 data: (user) {
//                   if (user != null) {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       Navigator.pushReplacementNamed(context, '/home');
//                     });
//                   }
//                   return const SizedBox.shrink();
//                 },
//                 error: (error, stack) => const SizedBox.shrink(),
//                 loading: () => const SizedBox.shrink(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }