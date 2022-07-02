import 'package:five_by_five/src/player/domain/player.dart';

typedef GroupId = String;

// Features: 1. Display players in a Group. 2. Allow tier-based 
class Group {
  Group({
    required this.groupId,
    required this.title,
    required this.playerList,
  });

  GroupId groupId;
  String title;
  List<Player> playerList;

  @override
  String toString() {
    return "$title\n"
        "${playerList.map((e) => "$e\n")}";
  }

  /// Creates a Group object from Firestore object from GroupData.
  static createGroup(Map<String, dynamic> groupData) {
    if (groupData.isEmpty) {
      return Group(groupId: "", title: "", playerList: <Player>[]);
    }
    List<Player> players = groupData["playerList"];
    return Group(
        groupId: groupData["GroupId"],
        title: groupData["title"],
        playerList: players);
  }

  static Map<String, dynamic> toMap(Group group) {
    return <String, dynamic>{
      "GroupId": group.groupId,
      "title": group.title,
      "playerList": group.playerList,
    };
  }
}
