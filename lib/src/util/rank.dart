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
        return -1;
    }
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
