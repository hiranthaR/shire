import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shire/models/user.dart';
import 'package:shire/databases/users.dart';

class ShoutBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.0),
      margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.lightBlueAccent,
        border: Border.all(color: Colors.blueGrey, style: BorderStyle.solid),
      ),
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("shouts")
              .orderBy("id", descending: true)
              .limit(2)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (!snapshots.hasData)
              return Container(
                  width: double.infinity, child: CircularProgressIndicator());

            var docs = snapshots.data.documents;

            return Column(
              children: <Widget>[
                Text("Shout Box"),

                //shout card 1
                docs.length > 0
                    ? FutureBuilder<User>(
                        future: getUser(docs[0].data["uid"]),
                        builder: (BuildContext context,
                            AsyncSnapshot<User> userSnap) {
                          return userSnap.hasData
                              ? ShoutCard(
                                  user: userSnap.data,
                                  message: Html(data: docs[0].data["shout"]))
                              : Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircularProgressIndicator());
                        },
                      )
                    : Container(),

                //shout card 2
                docs.length > 1
                    ? FutureBuilder<User>(
                        future: getUser(docs[1].data["uid"]),
                        builder: (BuildContext context,
                            AsyncSnapshot<User> userSnap) {
                          return userSnap.hasData
                              ? ShoutCard(
                                  user: userSnap.data,
                                  message: Html(data: docs[1].data["shout"]))
                              : Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircularProgressIndicator());
                        },
                      )
                    : Container(),

                //shout box actions
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
                              children: <Widget>[
                                Icon(Icons.hearing),
                                Text("Shout")
                              ],
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
            );
          }),
    );
  }
}

class ShoutCard extends StatelessWidget {
  final User user;
  final Html message;

  final List<String> menuOptions = const <String>["Delete", "Report to Staff"];

  ShoutCard({@required this.user, @required this.message});

  void _viewProfile(User user) {
    print(user.displayName);
  }

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
                child: InkWell(
                  onTap: () => _viewProfile(user),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl == null
                        ? "https://www.shareicon.net/download/512x512/2016/09/15/829473_man_512x512.png"
                        : user.photoUrl),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: InkWell(
                    child: Text(
                      user.displayName,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => _viewProfile(user),
                  ),
                ),
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
