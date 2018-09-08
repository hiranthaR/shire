import 'package:flutter/material.dart';
import 'package:shire/databases/shouts.dart';

class ShoutScreen extends StatelessWidget {
  final shoutTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Shouts"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          TextField(
            autofocus: true,
            maxLength: 255,
            controller: shoutTextController,
            onSubmitted: (shoutText) {
              insertShout(shoutTextController.text);
              shoutTextController.clear();
            },
          ),
          RaisedButton(
            child: Text("Post Shout"),
            onPressed: () {
              insertShout(shoutTextController.text);
              shoutTextController.clear();
            },
          )
        ]),
      ),
    );
  }
}
