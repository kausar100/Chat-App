import 'package:chat_app/view_models/room_view_model.dart';
import 'package:flutter/material.dart';

class RoomList extends StatelessWidget {
  final List<RoomViewModel> rooms;
  final Function(RoomViewModel) onRoomSelected;

  RoomList({required this.rooms, required this.onRoomSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];

          return ListTile(
            title: Text(room.title),
            trailing: const Icon(Icons.arrow_forward_ios),
            subtitle: Text(room.description),
            onTap: () {
              onRoomSelected(room);
            },
          );
        });
  }
}
