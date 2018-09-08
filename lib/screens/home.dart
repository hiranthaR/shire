import 'package:flutter/material.dart';
import 'package:shire/custom/widgets/custom_widgets.dart';
import 'package:shire/utils/auth.dart';
import 'package:shire/custom/widgets/shouts.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
          //staff message box
          StaffMessageBox(),

          //shout box
          ShoutBox(),
        ],
      )),
    );
  }
}
