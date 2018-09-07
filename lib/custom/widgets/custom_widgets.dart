
import 'package:flutter/material.dart';
import 'package:shire/models/user.dart';
import 'package:flutter_html/flutter_html.dart';

class StaffMessageBox extends StatelessWidget {
  final String message;

  StaffMessageBox({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3.0),
      padding: EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(50, 255, 194, 0),
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.amber, style: BorderStyle.solid)),
      child: Html(
        data: message,
      ),
    );
  }
}

class ShoutCard extends StatelessWidget {
  final User user;
  final Html message;

  final List<String> menuOptions = const <String>["Delete", "Report to Staff"];

  ShoutCard({@required this.user, @required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Colors.white),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 5.0, top: 3.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoUrl == null
                      ? "https://www.shareicon.net/download/512x512/2016/09/15/829473_man_512x512.png"
                      : user.photoUrl),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(user.displayName)),
              ),
              PopupMenuButton<String>(
                onSelected: null,
                itemBuilder: (BuildContext context) {
                  return menuOptions.map((String s) {
                    return PopupMenuItem<String>(
                      value: s,
                      child: Text(s),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.black26,
            margin: EdgeInsets.only(bottom: 20.0, top: 5.0),
          ),
          message,
          Container(
            margin: EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                        style: BorderStyle.solid,
                        width: 1.0,
                        color: Colors.black26))),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.thumb_up), onPressed: null),
                        Text("Like")
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.message), onPressed: null),
                        Text("Comment")
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 7.0,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
