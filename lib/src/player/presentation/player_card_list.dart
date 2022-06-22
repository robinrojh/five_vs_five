import 'package:five_by_five/src/player/data/repository/player_repository.dart';
import 'package:five_by_five/src/player/domain/player.dart';
import 'package:flutter/material.dart';

class PlayerCardList extends StatefulWidget {
  PlayerCardList({required this.playerList})
      : super(key: ObjectKey(playerList));

  final List<Player> playerList;

  @override
  _PlayerCardListState createState() => _PlayerCardListState();
}

class _PlayerCardListState extends State<PlayerCardList> {
  late Future<List<Player>> futurePlayerList;

  @override
  void initState() {
    super.initState();
    futurePlayerList = PlayerRepository.getPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Player>>(
        future: futurePlayerList,
        builder: (context, snapshot) {
          return Text(snapshot.data![0].toString());
        });
  }
}
