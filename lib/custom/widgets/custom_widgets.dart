import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shire/meta/current_user.dart';
import 'package:shire/models/user.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shire/databases/users.dart';

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

class ShoutBox extends StatefulWidget {
  @override
  State<ShoutBox> createState() => ShoutBoxState();
}

class ShoutBoxState extends State<ShoutBox> {
  StreamSubscription<QuerySnapshot> subscription;
  var shout1 = ShoutCard(user: getDummyUser(), message: Html(data: ""));
  var shout2 = ShoutCard(user: getDummyUser(), message: Html(data: ""));

  @override
  void initState() {
    super.initState();

    subscription = Firestore.instance
        .collection("shouts")
        .orderBy("id", descending: true)
        .limit(2)
        .snapshots()
        .listen((snapshots) async {
      var docs = snapshots.documents;
      if (docs.length > 0) {
        var user1 = await getUser(docs[0].data["uid"]);
        var user2 = await getUser(docs[1].data["uid"]);
        var shoutText1 = docs[0].data["shout"];
        var shoutText2 = docs[1].data["shout"];
        setState(() {
          shout1 = ShoutCard(user: user1, message: Html(data: shoutText1));
          shout2 = ShoutCard(user: user2, message: Html(data: shoutText2));
        });
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0.0),
      padding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 2.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.blue,
          border: Border.all(color: Colors.blueGrey, style: BorderStyle.solid)),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 2.0),
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0))),
            child: Text(
              "ShoutBox",
              textAlign: TextAlign.center,
            ),
          ),
          shout1,
          shout2,
          Container(
            margin: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 0.0),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 204, 206, 209),
                borderRadius: BorderRadius.circular(5.0)),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/post_shout");
                      },
                      child: Row(
                        children: <Widget>[Icon(Icons.hearing), Text("Shout")],
                      ),
                    ),
                    MaterialButton(
                      onPressed: null,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.history),
                          Text("History")
                        ],
                      ),
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
