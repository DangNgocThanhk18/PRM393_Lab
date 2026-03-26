// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'screens/task_list_screen.dart';
//
// final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Initialize timezone for scheduled notifications
//   tz.initializeTimeZones();
//
//   // Initialize notifications
//   await initializeNotifications();
//
//   runApp(const ProviderScope(child: MyApp()));
// }
//
// Future<void> initializeNotifications() async {
//   // Android initialization
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('@mipmap/ic_launcher');
//
//   // iOS initialization
//   final DarwinInitializationSettings initializationSettingsIOS =
//   DarwinInitializationSettings(
//     requestAlertPermission: true,
//     requestBadgePermission: true,
//     requestSoundPermission: true,
//     onDidReceiveLocalNotification: (id, title, body, payload) async {
//       // Handle notification when app is in foreground on iOS
//     },
//   );
//
//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsIOS,
//   );
//
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onDidReceiveNotificationResponse: (NotificationResponse response) async {
//       // Handle notification tap
//       print('Notification tapped: ${response.payload}');
//     },
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Local Notification Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }