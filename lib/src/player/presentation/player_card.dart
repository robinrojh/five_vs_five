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
    return Center(
      child: Text(widget.player.toString()));
  }
}