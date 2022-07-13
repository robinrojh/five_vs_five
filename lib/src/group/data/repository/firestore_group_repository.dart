import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_by_five/src/group/domain/group.dart';
import 'package:five_by_five/src/player/domain/player.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class FirestoreGroupRepository {
  static Future<List<Group>> getGroups() async {
    var groupRef = db.collection("groups");
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        (await groupRef.get()).docs;
    List<Group> groupList = List<Group>.empty(growable: true);
    await db.runTransaction((transaction) async {
      for (var element in docs) {
        var data = element.data();
        List playerDataList = data["playerList"];
        List<Player> playerList = [];
        for (var playerRef in playerDataList) {
          var playerData = (await transaction.get(playerRef));
          playerList.add(
              Player.createPlayer(playerData.data() as Map<String, dynamic>));
        }

        Group resultGroup = Group.createGroup({
          "groupId": data["groupId"],
          "title": data["title"],
          "playerList": playerList,
        });
        groupList.add(resultGroup);
      }
    });
    return groupList;
  }

  static Future<void> addGroup({required Group group}) async {
    if (group.playerList.length > 20) {
      throw Exception("Group has too many players!");
    }
    Map<String, dynamic> groupMap = Group.toMap(group);
    await db.collection("groups").add(groupMap);
  }

  static Future<void> addToGroup(
      {required GroupId groupId, required PlayerId playerId}) async {
    await db.collection("groups").doc(groupId).update({
      "playerList": FieldValue.arrayUnion([playerId]),
    });
  }

  static Future<void> deleteGroup({required GroupId groupId}) async {
    await db.collection("groups").doc(groupId).delete();
  }

  static Future<void> deleteFromGroup(
      {required GroupId groupId, required PlayerId playerId}) async {
    await db.collection("groups").doc(groupId).update({
      "playerList": FieldValue.arrayRemove([playerId]),
    });
  }

  static Future<void> editGroup(
      {required Group group, required Group editedGroup}) async {
    throw Exception("Function isn't ready yet.");
  }
}
