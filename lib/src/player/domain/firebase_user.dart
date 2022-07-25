import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser {
  FirebaseUser({required this.email, required this.groupList});

  String email;
  List<DocumentReference> groupList;

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "groupList": groupList,
    };
  }

  static FirebaseUser createFirebaseUser(Map<String, dynamic> userData) {
    return FirebaseUser(
        email: userData["email"],
        groupList: List<DocumentReference>.from(userData["groupList"]));
  }
}
