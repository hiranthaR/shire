import 'package:flutter/material.dart';
import 'package:shire/databases/shouts.dart';
import 'package:shire/meta/current_user.dart';

class ShoutScreen extends StatelessWidget {
  final shoutTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    try {
      getCurrentUser();
    } catch (e) {}
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Shouts"),
      ),
      body: Column(children: <Widget>[
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
          onPressed: () {
            insertShout(shoutTextController.text);
            shoutTextController.clear();
          },
        )
      ]),
    );
  }
}
