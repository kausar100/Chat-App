import 'dart:async';
import 'package:chat_app/pages/entry_point.dart';
import 'package:chat_app/services/local_notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //for background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //for showing notification when app is running
  LocalNotificationServices.initialize();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Lets Chat",
        theme: ThemeData(primaryColor: const Color(0xFF27ae60)),
        home: const EntryScreen());
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(
      "Handling a background message from main: ${message.notification!.title}");
  print(
      "Handling a background message from main: ${message.notification!.body}");
}
