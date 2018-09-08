import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class StaffMessageBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 5.0),
        padding: EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(50, 255, 194, 0),
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.amber, style: BorderStyle.solid)),
        child: Center(
          child: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance.document("/system/app_meta").snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshots) {
              if (!snapshots.hasData) return CircularProgressIndicator();
              return Html(data: snapshots.data.data['staff_message']);
            },
          ),
        ));
  }
}
