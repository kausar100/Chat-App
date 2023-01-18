

import 'package:chat_app/models/room.dart';
import 'package:chat_app/view_models/room_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RoomListViewModel {

  Future<List<RoomViewModel>> getAllRooms() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("rooms").get();
    final rooms = snapshot.docs.map((doc) => Room.fromDocument(doc)).toList();
    return rooms.map((room) => RoomViewModel(room: room)).toList();
  }

}