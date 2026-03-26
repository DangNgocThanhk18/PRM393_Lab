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
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.blue, Colors.purple],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const FlutterLogo(size: 100, color: Colors.white),
//               const SizedBox(height: 24),
//               const CircularProgressIndicator(color: Colors.white),
//               const SizedBox(height: 16),
//               Text(
//                 'Complete Auth App',
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }