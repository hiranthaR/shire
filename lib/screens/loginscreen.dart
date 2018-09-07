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
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              ShireImages.BACKGROUND,
              fit: BoxFit.cover,
              color: Colors.black45,
              colorBlendMode: BlendMode.darken,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 80.0),
              child: Wrap(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _trySignIn(context),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Image.asset(
                          ShireIcons.GOOGLE_ICON,
                          height: 30.0,
                        ),
                        Text("Sign With Google")
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
