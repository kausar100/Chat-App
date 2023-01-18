import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  void _signOut() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: _signOut,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text(
                "Sign Out",
                style: TextStyle(color: Colors.white),
              ),
            )
          ]),
        ));
  }
}
