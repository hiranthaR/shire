import 'package:meta/meta.dart';

class User {
  String uid;
  String displayName;
  String email;
  String phoneNumber;
  String photoUrl;

  User({
    @required this.uid,
    @required this.displayName,
    @required this.email,
    @required this.phoneNumber,
    @required this.photoUrl,
  });
}
