// // lib/screens/task_list_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/auth_provider.dart';
//
// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(authStateProvider).value;
//     final authNotifier = ref.read(authNotifierProvider.notifier);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Avatar
//               CircleAvatar(
//                 radius: 60,
//                 backgroundImage: user?.photoURL != null
//                     ? NetworkImage(user!.photoURL!)
//                     : null,
//                 child: user?.photoURL == null
//                     ? const Icon(Icons.person, size: 60)
//                     : null,
//               ),
//               const SizedBox(height: 24),
//
//               // Hiển thị tên
//               Text(
//                 user?.displayName ?? 'User',
//                 style: const TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//
//               // Hiển thị email
//               Text(
//                 user?.email ?? 'No email',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 48),
//
//               // Nút logout
//               ElevatedButton(
//                 onPressed: () async {
//                   await authNotifier.signOut();
//                   if (context.mounted) {
//                     Navigator.pushReplacementNamed(context, '/');
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 32,
//                     vertical: 16,
//                   ),
//                   backgroundColor: Colors.red,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Sign Out',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }