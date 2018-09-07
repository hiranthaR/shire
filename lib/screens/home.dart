import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shire/custom/widgets/custom_widgets.dart';
import 'package:shire/models/user.dart';
import 'package:shire/utils/auth.dart';
import 'package:shire/databases/users.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  StreamSubscription<DocumentSnapshot> subscription;

  String message = "";

  @override
  void initState() {
    super.initState();
    subscription = Firestore.instance
        .document("/system/app_meta")
        .snapshots()
        .listen((dataSnapshot) {
      if (dataSnapshot.exists) {
        setState(() {
          message = dataSnapshot.data['staff_message'];
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shire"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: Colors.white,
            ),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
            onPressed: () => signOut().then((_) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (Route<dynamic> route) => false)),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 0.0),
            padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
            width: double.infinity,
            child: StaffMessageBox(message: message),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("shouts")
                  .orderBy("id", descending: true)
                  .limit(2)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshots) {
                if (!snapshots.hasData) return Container();

                var docs = snapshots.data.documents;

                return Container(
                  padding: EdgeInsets.all(3.0),
                  margin: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.blue,
                    border: Border.all(
                        color: Colors.blueGrey, style: BorderStyle.solid),
                  ),
                  child: Column(
                    children: <Widget>[

                      Text("Shout Box",),
                      docs.length > 0
                          ? FutureBuilder<User>(
                              future: getUser(docs[0].data["uid"]),
                              builder: (BuildContext context,
                                  AsyncSnapshot<User> userSnap) {
                                return userSnap.hasData
                                    ? ShoutCard(
                                        user: userSnap.data,
                                        message:
                                            Html(data: docs[0].data["shout"]))
                                    : CircularProgressIndicator();
                              },
                            )
                          : Container(),
                      docs.length > 1
                          ? FutureBuilder<User>(
                              future: getUser(docs[1].data["uid"]),
                              builder: (BuildContext context,
                                  AsyncSnapshot<User> userSnap) {
                                return userSnap.hasData
                                    ? ShoutCard(
                                        user: userSnap.data,
                                        message:
                                            Html(data: docs[1].data["shout"]))
                                    : CircularProgressIndicator();
                              },
                            )
                          : Container(),
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
                  ),
                );
              })
        ],
      )),
    );
  }
}
