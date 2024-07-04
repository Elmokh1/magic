// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class FirebaseNotifications {
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//
//   void init() {
//     requestPermission();
//     _messaging.subscribeToTopic('all');
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Received message while in foreground: ${message.notification?.title}');
//       // Handle foreground message here
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Message clicked!');
//       // Handle notification click here
//     });
//   }
//
//   void requestPermission() async {
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
//
//   Future<void> sendNotification(String title, String body, String imageUrl) async {
//     final String serverToken = 'AIzaSyAQQMOMzOlECzpdBl_ZkAK7umIaE1xp6ic';
//     await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key=$serverToken',
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           'notification': <String, dynamic>{
//             'body': body,
//             'title': title,
//             'image': imageUrl,
//           },
//           'priority': 'high',
//           'data': <String, dynamic>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'id': '1',
//             'status': 'done'
//           },
//           'to': '/topics/all',
//         },
//       ),
//     );
//   }
// }
