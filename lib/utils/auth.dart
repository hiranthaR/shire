import 'dart:async';
import 'package:shire/databases/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shire/models/user.dart';

var _auth = FirebaseAuth.instance;
var _googleSignIn = GoogleSignIn();

Future<Null> signOut() async {
  await _auth.signOut();
  await _googleSignIn.signOut();
}

Future<FirebaseUser> signIn() async {
  var googleUser = _googleSignIn.currentUser;

  if (googleUser == null) {
    print("signed in silently");
    googleUser = await _googleSignIn.signInSilently();
  }

  if (googleUser == null) {
    print("signed in");
    googleUser = await _googleSignIn.signIn();
  }
  var authentication = await googleUser.authentication;

  var firebaseUser = await _auth.signInWithGoogle(
      idToken: authentication.idToken, accessToken: authentication.accessToken);

  print(firebaseUser.displayName);

  insertUser(
      firebaseUser.uid,
      User(
          uid: firebaseUser.uid,
          displayName: firebaseUser.displayName,
          email: firebaseUser.email,
          phoneNumber: firebaseUser.phoneNumber,
          photoUrl: firebaseUser.photoUrl));

  return firebaseUser;
}
