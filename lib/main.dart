import 'package:flutter/material.dart';
import 'package:shire/screens/chatroom_menu_screen.dart';
import 'package:shire/screens/home.dart';
import 'package:shire/screens/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shire/screens/shout_screen.dart';
import 'meta/current_user.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final Map<String, WidgetBuilder> routes = {
    "/login": (BuildContext context) => LoginScreen(),
    "/home": (BuildContext context) => HomeScreen(),
    "/post_shout": (BuildContext context) => ShoutScreen(),
    "/chatrooms": (BuildContext context) => ChatRoomsScreen(),
  };


  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return MaterialApp(
      title: "Shire",
      routes: routes,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, snapshot) {
            return snapshot.hasData ? HomeScreen() : LoginScreen();
          }),
    );
  }
}
