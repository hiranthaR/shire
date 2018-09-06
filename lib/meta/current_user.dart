import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shire/models/user.dart';

User _user;

User getCurrentUser() {
  if (_user != null) return _user;
  FirebaseAuth.instance.onAuthStateChanged.listen((FirebaseUser user) {
    if (user != null) {
      _user = User(
          uid: user.uid,
          displayName: user.displayName,
          email: user.email,
          phoneNumber: user.phoneNumber,
          photoUrl: user.photoUrl);
    }
  });
  return _user;
}

User getDummyUser() => User(
    uid: "ss",
    displayName: "Admin",
    email: "admin@shire.net",
    phoneNumber: "0702693523",
    photoUrl:
        "http://www.clker.com/cliparts/7/d/1/e/13318154281372242463user-md.png");
