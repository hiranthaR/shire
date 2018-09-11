import 'package:flutter/material.dart';
import 'package:shire/models/chatroom.dart';
import 'package:shire/screens/chatroom_screen.dart';

class ChatRoomRow extends StatelessWidget {
  final ChatRoom chatRoom;

  ChatRoomRow({@required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoomScreen(chatRoom: chatRoom,)));
        },
        child: Text(chatRoom.roomName),
      ),
    );
  } 
}
