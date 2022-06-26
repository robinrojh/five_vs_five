import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_by_five/src/player/domain/player.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class FirestorePlayerRepository {
  static Future<List<Player>> getPlayers() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var collection = await db.collection("players").get();
    var documentList = collection.docs;
    List<Player> playerList = List<Player>.empty(growable: true);
    for (var element in documentList) {
      var data = element.data();
      Player player = Player.createPlayer(data);
      playerList.add(player);
    }
    return playerList;
  }

  static Future<void> addPlayer({required Player player}) async {
    await db.collection("players").doc(player.playerId).set(<String, dynamic>{
      "playerId": player.playerId,
      "name": player.name,
      "currentRank": player.currentRank,
      "highestRank": player.highestRank,
    });
  }

  static Future<void> editPlayer(
      {required Player player, required Player editedPlayer}) async {
    await db.collection("players").doc(player.playerId).set(<String, dynamic>{
      "playerId": player.playerId,
      "name": player.name,
      "currentRank": player.currentRank,
      "highestRank": player.highestRank,
    });
  }

  static Future<void> deletePlayer({required Player player}) async {
    await db.collection("players").doc(player.playerId).delete();
  }
}
