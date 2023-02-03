import 'dart:async';
import 'package:chat_app/pages/entry_point.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //for background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class _AppState extends State<App> {


  @override
  void initState() {

    //  open from terminate state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print('app is open from terminate state');
      if (message != null) {
        print('New notification received');
      }
    });

    //when app is on foreground
    FirebaseMessaging.onMessage.listen((message) {
      print('app is running on foreground');
      if (message.notification != null) {
        print('${message.notification!.title}');
        print('${message.notification!.body}');
      }
    });

    //when the app is background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('app is running in the background');
      if (message.notification != null) {
        print('${message.notification!.title}');
        print('${message.notification!.body}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Lets Chat",
        theme: ThemeData(primaryColor: const Color(0xFF27ae60)),
        home: const EntryScreen());
  }
}

