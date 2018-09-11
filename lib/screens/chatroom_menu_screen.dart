import 'package:flutter/material.dart';
import 'package:shire/custom/widgets/chat_screen/chat_widgets.dart';
import 'package:shire/custom/widgets/home_screen/staff_message.dart';
import 'package:shire/models/chatroom.dart';

class ChatRoomsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatrooms"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          //staff message box
          StaffMessageBox(path: "/system/chat_meta", keyWord: 'staff_message'),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color:Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color:Colors.blue,width: 1.0)
            ),
            child: Column(
              children: <Widget>[
                ChatRoomRow(chatRoom: ChatRoom(roomName: "Public Chat Room"),),
                ChatRoomRow(chatRoom: ChatRoom(roomName: "SL Chat Roombl bl "),),
              ],
            ),
          )
        ],
      )),
    );
  }
}

