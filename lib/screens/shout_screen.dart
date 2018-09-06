import 'package:flutter/material.dart';
import 'package:shire/meta/current_user.dart';
import 'package:shire/databases/shouts.dart';

class ShoutScreen extends StatelessWidget {
  final shoutTextController = TextEditingController();

  void _postShout(String shoutText){
    insertShout(shoutText, getCurrentUser().uid);
    shoutTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    try {
      getCurrentUser().uid;
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
            _postShout(shoutText);
          },
        ),
        RaisedButton(
          onPressed: () => _postShout(shoutTextController.text),
        )
      ]),
    );
  }
}
