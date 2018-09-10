import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shire/meta/current_user.dart';

final SHOUTS = "shouts";

final _firestoreDB = Firestore.instance;
final _firestoreShoutsRef = _firestoreDB.collection(SHOUTS);
final _firestoreShoutsMetaRef = _firestoreDB.document("/system/shout_meta");

void insertShout(String shoutText) async {
  var user = await getCurrentUser();

  _firestoreDB.runTransaction((trans) async {
    await trans.get(_firestoreShoutsMetaRef).then((document) async {
      if (document.exists) {
        var id = document.data["id"];
        id++;
        _postShout(shoutText, id, user.uid);
        await trans.update(_firestoreShoutsMetaRef, {"id": id});
      } else {
        _postShout(shoutText, 0, user.uid);
        await trans.set(_firestoreShoutsMetaRef, {"id": 0});
      }
    });
  });
}

void _postShout(String shoutText, int id, String uid) {
  _firestoreShoutsRef.add({"uid": uid, "shout": shoutText, "id": id,});
}
