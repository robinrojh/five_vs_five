import 'package:five_by_five/src/player/domain/player.dart';

/// Defines the permissions for each player in a team (invite, edit).
/// Edit includes delete.
/// * Everyone can modify their own profile regardless of permission state.
/// Format in Firestore:
///   Invite and edit (admin permission): ie
///   Only invite: i-
///   Only edit: -e
///   None: --
typedef PlayerPermissions = String;

class Team {
  Team({
    required this.title,
    required this.playerList,
  });

  String title;
  Map<PlayerId, PlayerPermissions> playerList;

  @override
  String toString() {
    return "$title\n"
        "${playerList.keys.map((e) => "$e\n")}";
  }

  static createTeam(Map<String, dynamic> teamData) {
    Map<PlayerId, PlayerPermissions> players = teamData[playerList];
    return Team(teamData[title], players);
  }
}
