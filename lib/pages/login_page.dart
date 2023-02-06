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

  double _currentSliderValue = 20;
  double available = 200;
  double minValue = 20, maxValue = (200.0 / 20.0) * 20.0;
  int divisionValue = ((200.0 / 20.0) - 1.0).toInt();

  @override
  Widget build(BuildContext context) {
    print('min value : $minValue, max value ; $maxValue');
    print('division : $divisionValue, selected value : $_currentSliderValue');
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
        ),
        Center(child: Text('Selected Amount : $_currentSliderValue')),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (_currentSliderValue > minValue) {
                    setState(() {
                      _currentSliderValue = _currentSliderValue - minValue;
                    });
                  }
                },
                child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    )),
              ),
              Expanded(
                child: Slider(
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                  value: _currentSliderValue,
                  activeColor: Colors.blue,
                  label: _currentSliderValue.round().toString(),
                  divisions: divisionValue,
                  inactiveColor: Colors.black,
                  min: minValue,
                  max: maxValue,
                ),
              ),
              InkWell(
                onTap: () {
                  if (_currentSliderValue < maxValue) {
                    setState(() {
                      _currentSliderValue = _currentSliderValue + minValue;
                    });
                  }
                },
                child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
