import 'package:flutter/material.dart';
import 'package:shire/custom/widgets/home_screen/menu.dart';
import 'package:shire/custom/widgets/home_screen/staff_message.dart';
import 'package:shire/utils/auth.dart';
import 'package:shire/custom/widgets/home_screen/shouts.dart';
import 'package:shire/meta/current_user.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    try {
      getCurrentUser();
    } catch (e) {}
    return Scaffold(
      appBar: AppBar(
        title: Text("Shire"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: Colors.white,
            ),
            onPressed: () {},
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
          StaffMessageBox(path: "/system/app_meta", keyWord: 'staff_message'),

          //shout box
          ShoutBox(),
          HomeScreenMenu(),
        ],
      )),
    );
  }
}
