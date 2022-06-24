import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five_by_five/src/team/domain/team.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
class FirestoreTeamRepository {
  // Retrieves data necessary to render a team in the home page
  static Future<List<Team>> getTeams() async {
    var collection = await db.collection("teams").get();
    var documentList = collection.docs;
    documentList.forEach((element) {
      var teamData = element.data();
    });
  }

  static Future<Team> getTeam() async {
    
  }
}