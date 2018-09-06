import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shire/custom/widgets/custom_widgets.dart';
import 'package:shire/utils/auth.dart';

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
          ShoutBox()
        ],
      )),
    );
  }
}
