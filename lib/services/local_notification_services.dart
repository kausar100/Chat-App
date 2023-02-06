import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  static final notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() async {
    const initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    await notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static void createNotification(RemoteMessage message) async {
    try {
      int id = message.notification!.hashCode;

      const notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              'notificationId',
              'notificationChannel',
              importance: Importance.max,
              priority: Priority.high));

      await notificationsPlugin.show(id, message.notification!.title,
         message.notification!.body, notificationDetails);
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}