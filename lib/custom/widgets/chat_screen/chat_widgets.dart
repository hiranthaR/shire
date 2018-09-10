import 'package:flutter/material.dart';
import 'package:shire/models/chatroom.dart';

class ChatRoomRow extends StatelessWidget {
  final ChatRoom chatRoom;

  ChatRoomRow({@required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        onPressed: (){

        },
        child: Text(chatRoom.roomName),
      ),
    );
  }
}
