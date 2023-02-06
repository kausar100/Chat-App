import 'dart:async';

import 'package:chat_app/main.dart';
import 'package:chat_app/pages/new_splash_screen.dart';
import 'package:chat_app/services/local_notification_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unique_identifier/unique_identifier.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  Future<String> _getDeviceToken() async {
    final notificationToken = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print('token : ${notificationToken!}');
    }
    return notificationToken!;
  }

  Future<dynamic> _getDeviceInfo() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }
    return identifier;
  }

  Future<bool> _checkUpdate() async {
    return Future.delayed(const Duration(milliseconds: 300), () => false);
  }

  Future<bool> getTokenAndDeviceInfo() async {
    String? fcm, imei;

    print('fcm and imei fetching start...');

    fcm = await _getDeviceToken();
    print('token : $fcm');

    imei = await _getDeviceInfo();
    print('serial number : $imei');

    print('fcm and imei fetching done...');
    return true;
  }

  Future<bool> getTokenAndDeviceInfo2() async {
    String? fcm, imei;

    print('fcm and imei fetching start...');

    await _getDeviceInfo().then(
      (value) => print('serial number : $value'),
    );

    await _getDeviceToken().then((value) => print('token : $value'));

    print('fcm and imei fetching done...');
    return true;
  }

  init() {
    getTokenAndDeviceInfo().then((value) {
      _checkUpdate().then((updateStatus) =>
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (context) => const NewSplashScreen(),
            settings: RouteSettings(arguments: updateStatus),
          )));
    });
  }

  _initFCMServices() {
    //  open from terminate state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print('app is open from terminate state');
      if (message != null && message.notification != null) {
        print(message.notification!.title.toString());

        print(message.notification!.body.toString());

        setState(() {
          notificationTitle = message.notification!.title.toString();
          notificationBody = message.notification!.body.toString();
        });
      }
    });

    //when app is on foreground
    FirebaseMessaging.onMessage.listen((message) {
      print('app is running on foreground');
      if (message.notification != null) {
        print(message.notification!.title.toString());

        print(message.notification!.body.toString());

        //show notification with flutter_local_notification
        LocalNotificationServices.createNotification(message);
      }
    });

    //when the app is background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('app is running in the background');
      if (message.notification != null) {
        print(message.notification!.title.toString());

        print(message.notification!.body.toString());

        setState(() {
          notificationTitle = message.notification!.title.toString();
          notificationBody = message.notification!.body.toString();
        });
      }
    });
  }

  @override
  void initState() {
    _initFCMServices();
    init();
    getTokenAndDeviceInfo();
    super.initState();
  }

  String notificationTitle = '', notificationBody = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(notificationTitle)),
      body: Center(
        child: Text(notificationBody),
      ),
    );
  }
}
