import 'dart:async';
import 'dart:io';

import 'package:chat_app/pages/login_page.dart';
import 'package:flutter/material.dart';


class NewSplashScreen extends StatefulWidget {
  const NewSplashScreen({super.key});

  @override
  State<NewSplashScreen> createState() => _NewSplashScreenState();
}

class _NewSplashScreenState extends State<NewSplashScreen> {


  _nextPage() {
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool check = ModalRoute.of(context)?.settings.arguments as bool;

    if (check == false) {
      _nextPage();
    }

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF283771),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 70,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
                      child: Text(
                        'Lets talk about anything!!!',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          if (check == true)
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "New Update Available",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Please Update your app for continue...',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {
                                exit(0);
                              },
                              child: const Text('No')),
                          TextButton(
                              onPressed: () {
                                navigateNext(context);
                              },
                              child: const Text('Yes'))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  void navigateNext(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }
}

/*
Future<dynamic> alertDialog(BuildContext ctx) {
  return showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: ((context) => AlertDialog(
            title: const Text("Alert Dialog"),
            contentPadding: const EdgeInsets.all(20.0),
            content: const Text('Are you sure you want to cancel this!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    exit(0);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(ctx).pushReplacement(CupertinoPageRoute(
                        builder: (ctx) => const SplashScreen()));
                  },
                  child: const Text('Yes'))
            ],
          )));
}

Future<dynamic> customDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: ((context) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Custom Dialog",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            'Id id ea culpa nisi sint mollit sit qui voluptate. Lorem incididunt ut proident non duis eiusmod sint officia amet sit incididunt. Reprehenderit anim id ad nostrud minim ea voluptate cillum est ipsum. Non velit magna ad et.')
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -50,
                  child: CircleAvatar(
                    radius: 50,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                )
              ],
            ),
          )));
}
*/