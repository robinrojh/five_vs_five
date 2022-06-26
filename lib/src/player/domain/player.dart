typedef PlayerId = String;
typedef Rank = List<String>;

class Player {
  Player({
    required this.playerId,
    required this.name,
    required this.currentRank,
    required this.highestRank,
    required this.mainLanes,
  });

  PlayerId playerId;
  String name;
  Rank currentRank;
  Rank highestRank;
  List<String> mainLanes;

  @override
  String toString() {
    String mainLanesString = mainLanes.join(", ");
    return "Player ID: $playerId\n"
        "Name: $name\n"
        "Main Lane: $mainLanesString\n"
        "Current Rank: ${currentRank[0]} ${currentRank[1]}\n"
        "Highest Rank: ${highestRank[0]} ${highestRank[1]}";
  }

  Map<String, dynamic> toMap() {
    return {
      "playerId": playerId,
      "name": name,
      "currentRank": currentRank,
      "highestRank": highestRank,
      "mainLanes": mainLanes,
    };
  }

  static Player createPlayer(Map<String, dynamic> playerData) {
    List<String> currentRank = List<String>.from(playerData["currentRank"]);
    List<String> highestRank = List<String>.from(playerData["highestRank"]);
    List<String> mainLanes = List<String>.from(playerData["mainLanes"]);

    return Player(
        playerId: playerData["playerId"] as PlayerId,
        name: playerData["name"] as String,
        currentRank: currentRank,
        highestRank: highestRank,
        mainLanes: mainLanes);
  }
}
