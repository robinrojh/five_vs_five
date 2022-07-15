import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_by_five/src/player/domain/player.dart';
import 'package:flutter/cupertino.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class FirestorePlayerRepository {
  static Future<void> signIn(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signInWithEmailAndPassword(email: email, password: password);
  }
  
  static Future<void> signUp(String email, String password) async  {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

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
    DocumentReference<Map<String, dynamic>> playerRef =
        db.collection("players").doc(player.playerId);
    bool isSuccess = false;
    await db.runTransaction((transaction) async {
      var doc = await transaction.get(playerRef);
      if (!doc.exists) {
        transaction.set(playerRef, <String, dynamic>{
          "playerId": player.playerId,
          "name": player.name,
          "currentRank": player.currentRank.rank,
          "highestRank": player.highestRank.rank,
          "mainLanes": player.mainLanes,
        });
        isSuccess = true;
      }
    });
    if (!isSuccess) {
      throw Exception("This player already exists!");
    }
  }

  static Future<void> editPlayer(
      {required Player player, required Player editedPlayer}) async {
    if (player != editedPlayer) {
      await db
          .collection("players")
          .doc(player.playerId)
          .update(<String, dynamic>{
        "name": editedPlayer.name,
        "currentRank": editedPlayer.currentRank.rank,
        "highestRank": editedPlayer.highestRank.rank,
        "mainLanes": editedPlayer.mainLanes,
      });
    } else {
      throw Exception("At least one field must be edited.");
    }
  }

  static Future<void> deletePlayer({required Player player}) async {
    await db.collection("players").doc(player.playerId).delete();
  }
}
