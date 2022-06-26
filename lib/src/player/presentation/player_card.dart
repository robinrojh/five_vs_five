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
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      SizedBox(
          width: 960,
          child: Card(
              child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(widget.player.toString()))))
    ]);
  }
}
