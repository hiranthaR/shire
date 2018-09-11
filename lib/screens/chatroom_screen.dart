import 'package:flutter/material.dart';
import 'package:shire/models/chatroom.dart';

class ChatRoomScreen extends StatelessWidget {
  final ChatRoom chatRoom;

  ChatRoomScreen({@required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(title: Text("Who is inside",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),trailing: Icon(Icons.people),),
            Divider(),
            ListTile(
              title: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Text("M"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("Hirantha Rathnayake"),
                  )
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Text("M"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("Hirantha Rathnayake"),
                  )
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Text("M"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("Hirantha Rathnayake"),
                  )
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Text("M"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("Hirantha Rathnayake"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(chatRoom.roomName),
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          children: <Widget>[
            Expanded(
              //chat body
              child: Container(
                color: Colors.yellow,
                margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              width: double.infinity,
              decoration: BoxDecoration(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 5.0, right: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0)),
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 90.0,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Type a message",
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                )),
                            maxLines: null,
                            controller: null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    tooltip: "Send Message",
                    onPressed: () {},
                    child: Icon(
                      Icons.send,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
