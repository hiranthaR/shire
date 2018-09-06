import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shire/models/shout.dart';
import 'package:shire/databases/users.dart';

final SHOUTS = "shouts";

final _firestoreDB = Firestore.instance;
final _firestoreShoutsRef = _firestoreDB.collection(SHOUTS);
final _firestoreShoutsMetaRef = _firestoreDB.document("/system/shout_meta");

void insertShout(String shoutText, String uid) async{
  _firestoreDB.runTransaction((trans) async {
    await trans.get(_firestoreShoutsMetaRef).then((document) async {
      if (document.exists) {
        var id = document.data["id"];
        id++;
        _postShout(shoutText, id, uid);
        await trans.update(_firestoreShoutsMetaRef, {"id": id});
      } else {
        _postShout(shoutText, 0, uid);
        await trans.set(_firestoreShoutsMetaRef, {"id": 0});
      }
    });
  });
}

void _postShout(String shoutText, int id, String uid) {
  _firestoreShoutsRef
      .document(id.toString())
      .setData({"uid": uid, "shout": shoutText,"id" : id});
}

//Future<List<Shout>> getShouts() async {
//  var shouts = List<Shout>();
//
//  var docs = await _firestoreShoutsRef.limit(2).getDocuments();
//
//  for (var doc in docs.documents) {
//    var user = await getUser(doc["uid"]);
//    shouts.add(Shout(message: doc.data["shout"], user: user));
//  }
//  print(shouts.length);
//  return shouts;
//}
