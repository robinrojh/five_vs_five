import 'package:five_by_five/src/player/data/repository/firestore_player_repository.dart';
import 'package:five_by_five/src/player/domain/player.dart';
import 'package:flutter/material.dart';

class PlayerCard extends StatefulWidget {
  PlayerCard({required this.player}) : super(key: ObjectKey(player));

  final Player player;

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.player.toString());
  }
}