import 'dart:math';

import 'package:five_by_five/src/player/domain/player.dart';
import 'package:flutter/material.dart';

class Rank extends Comparable<Rank> {
  Rank({required this.rank});

  Rank.fromString(String rankString) {
    List<String> rank = rankString.split(' ');
    if (rank.isEmpty || rank.length > 2) {
      throw Exception("Wrong Rank Value!");
    }
    this.rank = rank;
  }
  List<String> rank = [];

  static List<DropdownMenuItem<Rank>> getRanksAsDropdownMenuItems() {
    List<String> rankList = Rank.getListOfRanks();
    List<DropdownMenuItem<Rank>> result = [];
    for (var rankString in rankList) {
      result.add(DropdownMenuItem(
          value: Rank.fromString(rankString), child: Text(rankString)));
    }
    return result;
  }

  static List<String> getListOfRanks() {
    List<String> tierList = [
      "Iron",
      "Bronze",
      "Silver",
      "Gold",
      "Platinum",
      "Diamond"
    ];
    List<String> numberList = ["4", "3", "2", "1"];
    String master = "Master";
    String grandMaster = "Grand Master";
    String challenger = "Challenger";
    List<String> rankList = getRankHelper(tierList, numberList);
    rankList.addAll([master, grandMaster, challenger]);
    return rankList;
  }

  static int mapTierToNumber(String tier) {
    switch (tier) {
      case "Iron":
        return 1;
      case "Bronze":
        return 2;
      case "Silver":
        return 3;
      case "Gold":
        return 4;
      case "Platinum":
        return 5;
      case "Diamond":
        return 6;
      case "Master":
        return 7;
      case "Grand Master":
        return 8;
      case "Challenger":
        return 9;
      default:
        return -1; // invalid
    }
  }

  static int getTierNumber(String rank) {
    /// rankList[0] contains the tier, and rankList[1] contains the number
    /// if rankList[0] is a tier above diamond, rankList[1] would not exist.
    List<String> rankList = rank.split(" ");
    if (rankList.length == 2) {
      return int.parse(rankList[1]);
    } else {
      return -1; // Master, Grandmaster, or Challenger
    }
  }

  /// Returns the power of a player.
  /// The power of a player is hard coded based on his/her rank.
  static int getPower(String rank) {
    int number = getTierNumber(rank);
    String tier = rank.split(" ")[0];
    if (number == -1) {
      switch (tier) {
        case "Unranked":
          return 0;
        case "Master":
          return 30;
        case "Grand Master":
          return 40;
        case "Challenger":
          return 50;
      }
    } else {
      switch (tier) {
        case "Iron":
          return 0 + 5 - number; // 1 to 4
        case "Bronze":
          return 4 + 5 - number; // 5 to 8
        case "Silver":
          return 8 + 5 - number; // 9 to 12
        case "Gold":
          return 12 + 5 - number; // 13 to 16
        case "Platinum":
          return 16 + 5 - number; // 17 to 20
        case "Diamond":
          return 20 + 5 - number; // 21 to 24
      }
    }
    return -1;
  }

  static List<String> getRankHelper(List<String> tiers, List<String> numbers) {
    List<String> result = [];
    for (int r = 0; r < tiers.length; r++) {
      for (int n = 0; n < numbers.length; n++) {
        result.add("${tiers[r]} ${numbers[n]}");
      }
    }
    return result;
  }

  static Rank getRandomRank() {
    int tier = Random().nextInt(9) + 1;
    int number = Random().nextInt(4) + 1;
    switch (tier) {
      case 1:
        return Rank.fromString("Iron $number");
      case 2:
        return Rank.fromString("Bronze $number");
      case 3:
        return Rank.fromString("Silver $number");
      case 4:
        return Rank.fromString("Gold $number");
      case 5:
        return Rank.fromString("Platinum $number");
      case 6:
        return Rank.fromString("Diamond $number");
      case 7:
        return Rank.fromString("Master");
      case 8:
        return Rank.fromString("Grand Master");
      case 9:
        return Rank.fromString("Challenger");
      default:
        return Rank.fromString("Silver 3");
    }
  }

  /// Calculates the power difference between the two given teams.
  /// If the returned value == 0, the two teams have the same power.
  /// If the returned value < 0, team 2 is stronger than team 1.
  /// If the returned value > 0, team 1 is stronger than team 2.
  static double calculatePowerDifference(
      List<Player> team1, List<Player> team2) {
    if (team1.length != 5) {
      return -1;
    } else if (team2.length != 5) {
      return -1;
    }

    double power1 = getTeamPower(team1);
    double power2 = getTeamPower(team2);
    return power1 - power2;
  }

  /// Returns the power of all players added, each player's power calculated as average of
  /// current rank and highest rank.
  static double getTeamPower(List<Player> team) {
    double result = 0;
    team.forEach((element) {
      double power = (getPower(element.currentRank.toString()) +
          getPower(element.highestRank.toString())) as double;
      power /= 2;
      result += power;
    });
    return result;
  }

  static List getAllSubsets(List list) =>
      list.fold<List>([[]], (subLists, element) {
        return subLists
            .map((subList) => [
                  subList,
                  subList + [element]
                ])
            .expand((element) => element)
            .toList();
      });

  static List getSizedSubsets(List list, int size) =>
      getAllSubsets(list).where((element) => element.length == size).toList();

  static List<Player> getOppositeTeam(
      List<Player> team1, List<Player> playerList) {
    if (team1.length != 5) {
      throw Exception("The number of team members is not 5.");
    }
    List<Player> copyPlayerList = List.from(playerList);
    team1.forEach((element) {
      copyPlayerList.remove(element);
    });
    return copyPlayerList;
  }

  /// Returns all subsets of teams that has a power difference less than powerDifference.
  static List<List<Player>> getSubsetsWithSimilarPower(
      List<Player> playerList, double powerDifference) {
    List subset = getSizedSubsets(playerList, 5);
    List<List<Player>> teams = List<List<Player>>.empty(growable: true);
    subset.forEach((list) {
      List<Player> newList = List<Player>.empty(growable: true);
      list.forEach((player) => newList.add(player as Player));
      teams.add(newList);
    });
    if (subset.isEmpty) {
      throw Exception("An error occurred while sorting teams.");
    }
    return teams.where((team) {
      List<Player> oppositeTeam = getOppositeTeam(team, playerList);
      return Rank.calculatePowerDifference(
                  team, oppositeTeam)
              .abs() <
          powerDifference && getLaneBalanceScore(team) >= 3 && getLaneBalanceScore(oppositeTeam) >= 3;
    }).toList();
  }

  static int getLaneBalanceScore(List<Player> playerList) {
    if (playerList.length != 5) {
      throw Exception("The player list must exactly contain 5 players.");
    }
    int score = 0;
    Map<String, int> countMap = {
      "Top": 0,
      "Jungle": 0,
      "Mid": 0,
      "ADC": 0,
      "Support": 0
    };
    for (var player in playerList) {
      for (var lane in player.mainLanes) {
        countMap[lane] = countMap[lane]! + 1;
      }
    }
    return countMap.values.fold(0, (previousValue, element) {
      int modifier = 0;
      if (element > 0) {
        modifier += 1;
      }
      return previousValue + modifier;
    });
  }

  @override
  String toString() {
    return "${rank[0]} ${rank[1]}";
  }

  @override
  bool operator ==(Object other) {
    if (other is Rank) {
      return rank[0] == other.rank[0] && rank[1] == other.rank[1];
    } else {
      return false;
    }
  }

  @override
  int compareTo(Rank other) {
    if (mapTierToNumber(rank[0]) > mapTierToNumber(other.rank[0])) {
      return 1;
    } else if (mapTierToNumber(rank[0]) == mapTierToNumber(other.rank[0])) {
      if (int.parse(rank[1]) < int.parse(other.rank[1])) {
        return 1;
      } else if (int.parse(rank[1]) == int.parse(other.rank[1])) {
        return 0;
      } else {
        return -1;
      }
    } else {
      return -1;
    }
  }
}
