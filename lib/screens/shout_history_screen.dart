import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shire/custom/widgets/home_screen/shouts.dart';
import 'package:shire/databases/users.dart';
import 'package:shire/models/user.dart';

class ShoutHistoryScreen extends StatefulWidget {
  @override
  _ShoutHistoryScreenState createState() => _ShoutHistoryScreenState();
}

class _ShoutHistoryScreenState extends State<ShoutHistoryScreen> {

  List<Widget> _getShoutsList(List<DocumentSnapshot> docs){
    return docs.map((doc){
      return FutureBuilder<User>(
        future: getUser(doc.data["uid"]),
        builder:
            (BuildContext context, AsyncSnapshot<User> userSnap) {
          return userSnap.hasData
              ? ShoutCard(
              poster: userSnap.data,
              doc: doc,)
              : Padding(
              padding: EdgeInsets.all(5.0),
              child: CircularProgressIndicator());
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Previous Shouts"),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("shouts")
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshots) {
                if (!snapshots.hasData)
                  return Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());

                var docs = snapshots.data.documents;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                    _getShoutsList(docs),

                );

              }),
        ),
      ),
    );
  }
}
