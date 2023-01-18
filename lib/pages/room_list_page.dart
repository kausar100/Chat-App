import 'package:chat_app/pages/add_room_page.dart';
import 'package:chat_app/pages/message_list_page.dart';
import 'package:chat_app/view_models/add_room_view_model.dart';
import 'package:chat_app/view_models/room_list_view_model.dart';
import 'package:chat_app/view_models/room_view_model.dart';
import 'package:chat_app/widgets/room_list.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class RoomListPage extends StatefulWidget {
  @override
  _RoomListPage createState() => _RoomListPage();
}

class _RoomListPage extends State<RoomListPage> {
  final RoomListViewModel _roomListVM = RoomListViewModel();
  List<RoomViewModel> _rooms = [];

  @override
  void initState() {
    super.initState();
    _populateRooms();
  }

  void _populateRooms() async {
    final rooms = await _roomListVM.getAllRooms();
    setState(() {
      _rooms = rooms;
    });
  }

  void _navigateToAddRoomPage(BuildContext context) async {
    bool roomAdded = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => AddRoomViewModel(), child: AddRoomPage()),
            fullscreenDialog: true));

    if (roomAdded != null && roomAdded) {
      _populateRooms();
    }
  }

  void _navigateToMessagesByRoom(RoomViewModel room, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MessageListPage(room: room)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rooms"),
          actions: [
            GestureDetector(
                onTap: () {
                  _navigateToAddRoomPage(context);
                },
                child: const Icon(Icons.add))
          ],
        ),
        body: RoomList(
            rooms: _rooms,
            onRoomSelected: (room) {
              // perform a navigation
              _navigateToMessagesByRoom(room, context);
            }));
  }
}
