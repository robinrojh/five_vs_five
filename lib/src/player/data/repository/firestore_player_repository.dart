import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_by_five/src/player/data/repository/player_repository.dart';
import 'package:five_by_five/src/player/domain/player.dart';

class FirestorePlayerRepository implements PlayerRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<Player> getPlayer({required PlayerId playerId}) async {
    var document = await db.collection("players").doc(playerId).get();
    Player playerData = document.data() as Player;
    return playerData;
  }

  @override
  Future<void> addPlayer({required Player player}) async {
    await db.collection("players").doc(player.playerId).set(<String, dynamic>{
      "playerId": player.playerId,
      "name": player.name,
      "currentRank": player.currentRank,
      "highestRank": player.highestRank,
    });
  }
}
