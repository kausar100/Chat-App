

import 'package:chat_app/pages/room_list_page.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  @override 
  _MainPage createState() => _MainPage(); 
}

class _MainPage extends State<MainPage> {

  int _selectedIndex = 0; 

  final List<Widget> _pages = <Widget>[
    RoomListPage(), 
    SettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; 
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: "Home"
          ), 
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), 
            label: "Settings"
          )
        ],
        onTap: _onItemTapped,
      ),
    );
    
  }
}