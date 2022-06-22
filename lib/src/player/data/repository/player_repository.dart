import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_by_five/src/player/domain/player.dart';

abstract class PlayerRepository {
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

  Future<Player> getPlayer({required PlayerId playerId});
  Future<void> addPlayer({required Player player});
  // Future<Player> deletePlayer({Player player});
  // Future<Player> deletePlayerById({PlayerId playerId});
  // Future<Player> editPlayer({PlayerId playerId, Player editedPlayer});
}
