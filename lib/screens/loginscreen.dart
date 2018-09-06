import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shire/utils/auth.dart';
import 'package:shire/utils/icons.dart';
import 'package:shire/utils/images.dart';

class LoginScreen extends StatelessWidget {
  void _trySignIn(BuildContext context) {
    signIn()
        .then((FirebaseUser user) =>
            Navigator.pushReplacementNamed(context, "/home"))
        .catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shire"),
          automaticallyImplyLeading: false,
        ),
        body: Builder(
            builder: (context) => Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      ShireImages.BACKGROUND,
                      fit: BoxFit.cover,
                      color: Colors.black45,
                      colorBlendMode: BlendMode.darken,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.black45,
                          onPressed: () => _trySignIn(context),
                          elevation: 12.0,
                          child: Container(
                              padding: EdgeInsets.all(5.0),
                              width: 180.0,
                              child: Wrap(children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      ShireIcons.GOOGLE_ICON,
                                    ),
                                    Text(
                                      "Sign in with Google",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ])),
                        )
                      ],
                    )
                  ],
                )));
  }
}
