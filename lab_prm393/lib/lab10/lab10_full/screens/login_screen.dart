// // lib/screens/login_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/auth_provider.dart';
// import '../providers/notification_provider.dart';
//
// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _isApiLogin = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkNotificationPermission();
//   }
//
//   void _checkNotificationPermission() async {
//     final notificationService = ref.read(notificationProvider);
//     await notificationService.requestPermissions();
//   }
//
//   Future<void> _handleApiLogin() async {
//     if (_formKey.currentState!.validate()) {
//       final authNotifier = ref.read(authStateProvider.notifier);
//       await authNotifier.loginWithApi(
//         _usernameController.text.trim(),
//         _passwordController.text,
//       );
//
//       final authState = ref.read(authStateProvider);
//       authState.when(
//         data: (user) {
//           if (user != null) {
//             Navigator.pushReplacementNamed(context, '/home');
//           }
//         },
//         error: (error, stack) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(error.toString().replaceAll('Exception:', '')),
//               backgroundColor: Colors.red,
//             ),
//           );
//         },
//         loading: () {},
//       );
//     }
//   }
//
//   Future<void> _handleGoogleLogin() async {
//     final authNotifier = ref.read(authStateProvider.notifier);
//     await authNotifier.loginWithGoogle();
//
//     final authState = ref.read(authStateProvider);
//     authState.when(
//       data: (user) {
//         if (user != null) {
//           Navigator.pushReplacementNamed(context, '/home');
//         }
//       },
//       error: (error, stack) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Google Sign-In failed: $error'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       },
//       loading: () {},
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authState = ref.watch(authStateProvider);
//
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                 const SizedBox(height: 40),
//             const Text(
//               'Welcome',
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Sign in to continue',
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 32),
//             // Toggle between API and Google login
//             SegmentedButton<bool>(
//               segments: const [
//                 ButtonSegment(value: true, label: Text('API Login')),
//                 ButtonSegment(value: false, label: Text('Google Login')),
//               ],
//               selected: {_isApiLogin},
//               onSelectionChanged: (Set<bool> selection) {
//                 setState(() {
//                   _isApiLogin = selection.first;
//                 });
//               },
//             ),
//             const SizedBox(height: 24),
//             if (_isApiLogin) ...[
//         Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _usernameController,
//               decoration: const InputDecoration(
//                 labelText: 'Username',
//                 prefixIcon: Icon(Icons.person),
//                 border: OutlineInputBorder(),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter username';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 prefixIcon: const Icon(Icons.lock),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _obscurePassword
//                         ? Icons.visibility
//                         : Icons.visibility_off,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _obscurePassword = !_obscurePassword;
//                     });
//                   },
//                 ),
//                 border: const OutlineInputBorder(),
//               ),
//               obscureText: _obscurePassword,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter password';
//                 }
//                 if (value.length < 6) {
//                   return 'Password must be at least 6 characters';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: authState.isLoading ? null : _handleApiLogin,
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//               ),
//               child: authState.isLoading
//                   ? const SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                 ),
//               )
//                   : const Text('Login with API'),
//             ),
//           ],
//         ),
//       ),
//       ] else ...[
//     ElevatedButton.icon(
//     onPressed: authState.isLoading ? null : _handleGoogleLogin,
//     icon: Image.asset(
//     'assets/google_logo.png',
//     height: 24,
//       width: 24,
//     ),
//     label: const Text('Sign in with Google'),
//     style: ElevatedButton.styleFrom(
//     padding: const EdgeInsets.symmetric(vertical: 16),
//     backgroundColor: Colors.white,
//     foregroundColor: Colors.black,
//     elevation: 2,
//     ),
//     ),
//     ],
//     if (_isApiLogin) ...[
//     const SizedBox(height: 24),
//     Container(
//     padding: const EdgeInsets.all(12),
//     decoration: BoxDecoration(
//     color: Colors.grey[200],
//     borderRadius: BorderRadius.circular(8),
//     ),
//     child: const Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     Text(
//     'Test Credentials:',
//     style: TextStyle(fontWeight: Font