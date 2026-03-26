// // lib/providers/notification_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import '../main.dart';
//
// final notificationProvider = Provider((ref) => NotificationService());
//
// class NotificationService {
//   final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       flutterLocalNotificationsPlugin;
//
//   Future<bool> requestPermissions() async {
//     if (await _notificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.areNotificationsEnabled() ??
//         false) {
//       return true;
//     }
//
//     final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
//     _notificationsPlugin.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//
//     final bool? granted = await androidImplementation?.requestPermission();
//     return granted ?? false;
//   }
//
//   Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//     String? payload,
//   }) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'auth_channel',
//       'Authentication Channel',
//       channelDescription: 'Channel for authentication notifications',
//       importance: Importance.high,
//       priority: Priority.high,
//       playSound: true,
//       enableVibration: true,
//       icon: '@mipmap/ic_launcher',
//     );
//
//     const DarwinNotificationDetails iosPlatformChannelSpecifics =
//     DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iosPlatformChannelSpecifics,
//     );
//
//     await _notificationsPlugin.show(
//       id,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: payload,
//     );
//   }
//
//   Future<void> showDelayedNotification({
//     required int id,
//     required String title,
//     required String body,
//     required Duration delay,
//     String? payload,
//   }) async {
//     final scheduledTime = DateTime.now().add(delay);
//     await _showScheduledNotification(
//       id: id,
//       title: title,
//       body: body,
//       scheduledTime: scheduledTime,
//       payload: payload,
//     );
//   }
//
//   Future<void> _showScheduledNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime scheduledTime,
//     String? payload,
//   }) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'scheduled_channel',
//       'Scheduled Channel',
//       channelDescription: 'Channel for scheduled notifications',
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//
//     const DarwinNotificationDetails iosPlatformChannelSpecifics =
//     DarwinNotificationDetails();
//
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iosPlatformChannelSpecifics,
//     );
//
//     await _notificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(scheduledTime, tz.local),
//       platformChannelSpecifics,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//       payload: payload,
//     );
//   }
//
//   Future<void> cancelAllNotifications() async {
//     await _notificationsPlugin.cancelAll();
//   }
// }