import 'package:chat_app/pages/main_page.dart';
import 'package:chat_app/view_models/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String _message = "";

  final _usernameController = TextEditingController();
  final _loginVM = LoginViewModel();

  void _login(BuildContext context) async {
    final username = _usernameController.text;

    // check if username is not empty
    if (username.isEmpty) {
      setState(() {
        _message = "Username cannot be empty!";
      });
    } else {
      // perform login
      final isLoggedIn = await _loginVM.login(username);
      if (isLoggedIn) {
        // on successful login take the user to the main page
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
              maxRadius: 150,
              backgroundImage: AssetImage("assets/images/logo.png")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _usernameController,
            decoration: const InputDecoration(hintText: "Enter username"),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _login(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_message),
        )
      ]),
    ));
  }
}
