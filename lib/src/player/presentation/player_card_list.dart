import 'package:five_by_five/src/player/domain/player.dart';
import 'package:five_by_five/src/player/presentation/player_card.dart';
import 'package:flutter/material.dart';

class PlayerCardList extends StatefulWidget {
  PlayerCardList({required this.playerList})
      : super(key: ObjectKey(playerList));

  final List<Player> playerList;

  @override
  _PlayerCardListState createState() => _PlayerCardListState();
}

class _PlayerCardListState extends State<PlayerCardList> {
  @override
  Widget build(BuildContext context) {
    // return Text(widget.playerList[0].toString());
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.playerList.length,
        itemBuilder: (context, index) {
          return PlayerCard(player: widget.playerList[index]);
        });
  }
}
