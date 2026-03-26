// // lib/screens/splash_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/auth_provider.dart';
//
// class SplashScreen extends ConsumerStatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   ConsumerState<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends ConsumerState<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _navigate();
//   }
//
//   void _navigate() {
//     Future.delayed(const Duration(seconds: 2), () {
//       final authState = ref.read(authStateProvider);
//       authState.when(
//         data: (user) {
//           if (user != null) {
//             Navigator.pushReplacementNamed(context, '/home');
//           } else {
//             Navigator.pushReplacementNamed(context, '/login');
//           }
//         },
//         error: (error, stack) {
//           Navigator.pushReplacementNamed(context, '/login');
//         },
//         loading: () {},
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FlutterLogo(size: 100),
//             const SizedBox(height: 24),
//             const CircularProgressIndicator(),
//             const SizedBox(height: 16),
//             const Text('Loading...'),
//           ],
//         ),
//       ),
//     );
//   }
// }