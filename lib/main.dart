import 'package:chat_app/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class _AppState extends State<App> {
  late final FirebaseMessaging _messaging;

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    //for background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //for IOS
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // For handling the received notifications (Foreground messages)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Successfully get notification ${notification.title} and ${notification.body}')));
        });
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Successfully get notification ${notification.title} and ${notification.body}')));
      });
    } else {
      print('come live from terminated state');
    }
  }

  @override
  void initState() {
    checkForInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Successfully get notification ${notification.title} and ${notification.body}')));
      });
    });

    registerNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Lets Chat",
        theme: ThemeData(primaryColor: const Color(0xFF27ae60)),
        home: LoginPage());
  }
}

class PushNotification {
  String? title;
  String? body;
  PushNotification({this.title, this.body});
}
