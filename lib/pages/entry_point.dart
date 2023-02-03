import 'dart:async';

import 'package:chat_app/pages/new_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:unique_identifier/unique_identifier.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  
  _getDeviceToken() async {
    final notificationToken = await FirebaseMessaging.instance.getToken();
    print('token : ' + notificationToken.toString());
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
    return await Future.delayed(const Duration(milliseconds: 300), () => true);
  }

  @override
  void initState() {
    // _getDeviceToken();
    // _getDeviceInfo().then((value) {
    //   print(value.toString());
    // });
    _checkUpdate().then((value) =>  
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => const NewSplashScreen(),
        settings: RouteSettings(arguments: value),
      )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
