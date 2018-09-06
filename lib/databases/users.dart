import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shire/models/user.dart';

final _firestoreDB = Firestore.instance;
final _firestoreUsersRef = _firestoreDB.collection("users");

final UID = "uid";
final DISPLAY_NAME = "display_name";
final EMAIL = "email";
final PHONE_NUMBER = "phone_number";
final PHOTO_URL = "photo_url";

void insertUser(String uid, User user) {
  _firestoreUsersRef.document(user.uid).setData({
    "uid": user.uid,
    "display_name": user.displayName,
    "email": user.email,
    "phone_number": user.phoneNumber,
    "photo_url": user.photoUrl,
  }, merge: true);
}

Future<User> getUser(String uid) async {

  User user;

  await _firestoreUsersRef.document(uid).get().then((doc){
    user = User(
        uid: doc.data[UID],
        displayName: doc.data[DISPLAY_NAME],
        email: doc.data[EMAIL],
        phoneNumber: doc.data[PHONE_NUMBER],
        photoUrl: doc.data[PHOTO_URL]);
  });

  return user;
}
