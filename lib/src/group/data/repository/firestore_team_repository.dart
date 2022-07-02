import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_by_five/src/group/domain/group.dart';
import 'package:five_by_five/src/player/domain/player.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class FirestoreGroupRepository {
  static Future<List<Group>> getGroups() async {
    List<Group> groupList = List<Group>.empty(growable: true);
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = (await db.collection("groups").get()).docs;
    for (var element in docs) {
      // Create a temporary empty map that maps group ID to group data.
      Map<String, dynamic> docData = {};
      // Puts the id as key and data as value.
      docData.putIfAbsent(element.id, () => element.data());
      // Add the group created from the map into groupList.
      groupList.add(Group.createGroup(docData));
    }
    return groupList;
  }

  static Future<void> addGroup({required Group group}) async {
    if (group.playerList.length > 20) {
      throw Exception("Group has too many players!");
    }
    Map<String, dynamic> groupMap = Group.toMap(group);
    await db.collection("groups").add(groupMap);
  }

  static Future<void> deleteGroup({required GroupId groupId}) async {
    await db.collection("groups").doc(groupId).delete();
  }

  static Future<void> editGroup(
      {required Group group, required Group editedGroup}) async {}
}
