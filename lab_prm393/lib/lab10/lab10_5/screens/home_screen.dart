// // lib/screens/task_list_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/notification_provider.dart';
//
// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   bool _permissionGranted = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkPermissions();
//   }
//
//   Future<void> _checkPermissions() async {
//     final notificationService = ref.read(notificationProvider);
//     final granted = await notificationService.requestPermissions();
//     setState(() {
//       _permissionGranted = granted;
//     });
//   }
//
//   Future<void> _showImmediateNotification() async {
//     final notificationService = ref.read(notificationProvider);
//     await notificationService.showNotification(
//       id: DateTime.now().millisecond,
//       title: 'Immediate Notification',
//       body: 'This notification appears immediately!',
//       payload: 'immediate_notification',
//     );
//
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Notification sent!')),
//       );
//     }
//   }
//
//   Future<void> _showDelayedNotification() async {
//     final notificationService = ref.read(notificationProvider);
//     await notificationService.showDelayedNotification(
//       id: DateTime.now().millisecond,
//       title: 'Delayed Notification',
//       body: 'This notification appears after 5 seconds!',
//       delay: const Duration(seconds: 5),
//       payload: 'delayed_notification',
//     );
//
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Notification scheduled in 5 seconds!')),
//       );
//     }
//   }
//
//   Future<void> _showScheduledNotification() async {
//     final notificationService = ref.read(notificationProvider);
//     final scheduledTime = DateTime.now().add(const Duration(minutes: 1));
//
//     await notificationService.showScheduledNotification(
//       id: DateTime.now().millisecond,
//       title: 'Scheduled Notification',
//       body: 'This notification was scheduled for ${scheduledTime.hour}:${scheduledTime.minute}',
//       scheduledTime: scheduledTime,
//       payload: 'scheduled_notification',
//     );
//
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Notification scheduled for ${scheduledTime.hour}:${scheduledTime.minute}'),
//         ),
//       );
//     }
//   }
//
//   Future<void> _showMultipleNotifications() async {
//     final notificationService = ref.read(notificationProvider);
//
//     for (int i = 1; i <= 3; i++) {
//       await notificationService.showDelayedNotification(
//         id: i,
//         title: 'Notification $i',
//         body: 'This is notification number $i',
//         delay: Duration(seconds: i * 2),
//         payload: 'notification_$i',
//       );
//     }
//
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('3 notifications scheduled!')),
//       );
//     }
//   }
//
//   Future<void> _cancelAllNotifications() async {
//     final notificationService = ref.read(notificationProvider);
//     await notificationService.cancelAllNotifications();
//
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('All notifications cancelled!')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Local Notification Demo'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Icon(
//                           _permissionGranted ? Icons.check_circle : Icons.warning,
//                           color: _permissionGranted ? Colors.green : Colors.orange,
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             _permissionGranted
//                                 ? 'Notifications permission granted'
//                                 : 'Notifications permission not granted',
//                             style: TextStyle(
//                               color: _permissionGranted ? Colors.green : Colors.orange,
//                             ),
//                           ),
//                         ),
//                         if (!_permissionGranted)
//                           TextButton(
//                             onPressed: _checkPermissions,
//                             child: const Text('Request'),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Notification Examples',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: _showImmediateNotification,
//               icon: const Icon(Icons.notifications_active),
//               label: const Text('Show Immediate Notification'),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton.icon(
//               onPressed: _showDelayedNotification,
//               icon: const Icon(Icons.timer),
//               label: const Text('Show Delayed Notification (5 seconds)'),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton.icon(
//               onPressed: _showScheduledNotification,
//               icon: const Icon(Icons.schedule),
//               label: const Text('Schedule Notification (1 minute)'),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton.icon(
//               onPressed: _showMultipleNotifications,
//               icon: const Icon(Icons.notifications),
//               label: const Text('Show Multiple Notifications'),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//             const SizedBox(height: 12),
//             OutlinedButton.icon(
//               onPressed: _cancelAllNotifications,
//               icon: const Icon(Icons.cancel),
//               label: const Text('Cancel All Notifications'),
//               style: OutlinedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//             const SizedBox(height: 24),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '📱 Note:',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     '• Make sure app has notification permission\n'
//                         '• Notifications may not appear if app is in foreground\n'
//                         '• On Android 13+, you need to grant permission\n'
//                         '• Check device notification settings if not working',
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
