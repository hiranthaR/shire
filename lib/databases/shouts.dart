import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shire/meta/current_user.dart';

final _firestoreDB = Firestore.instance;
final _firestoreShoutsRef = _firestoreDB.collection("shouts");

void insertShout(String shoutText) async {
  var user = await getCurrentUser();
  _firestoreShoutsRef.add({
    "uid": user.uid,
    "shout": shoutText,
    "timestamp": FieldValue.serverTimestamp()
  });
}
