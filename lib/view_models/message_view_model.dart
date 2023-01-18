

import 'package:chat_app/models/message.dart';
import 'package:intl/intl.dart';

class MessageViewModel {

  final Message message; 

  MessageViewModel({required this.message});

  String get messageText {
    return message.messageText; 
  }

  String get username {
    return message.username; 
  }

  String get messageDate {
    return DateFormat("MM-dd-yyyy HH:mm:ss").format(message.dateCreated!);
  }

}