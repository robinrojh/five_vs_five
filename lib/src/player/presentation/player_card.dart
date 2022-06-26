import 'package:five_by_five/src/player/domain/player.dart';
import 'package:flutter/material.dart';

class PlayerCard extends StatefulWidget {
  PlayerCard({required this.player, required this.callback}) : super(key: ObjectKey(player));

  final Player player;
  final Function callback;

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  bool isChecked = false;
  void onCheckboxClick(bool? value) {
    if (value != null) {
      setState(() {
        isChecked = !isChecked;
        widget.callback(isChecked, widget.player);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      SizedBox(
          width: 960,
          child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 24.0, 0.0),
                      child: Checkbox(
                          value: isChecked, onChanged: onCheckboxClick),
                    ),
                    Text(widget.player.toString()),
                  ]))))
    ]);
  }
}
