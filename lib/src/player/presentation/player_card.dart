import 'package:five_by_five/src/player/data/repository/firestore_player_repository.dart';
import 'package:five_by_five/src/player/domain/player.dart';
import 'package:five_by_five/src/player/presentation/edit_player_form.dart';
import 'package:flutter/material.dart';

class PlayerCard extends StatefulWidget {
  PlayerCard({required this.player, required this.callback})
      : super(key: ObjectKey(player));

  final Player player;
  final Function callback;

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  bool isChecked = false;
  showDeleteDialog(BuildContext context, Player player) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed: () {
        FirestorePlayerRepository.deletePlayer(player: player);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm Delete?"),
      content: Text(
          "Are you sure you want to delete this player? This action is irreversible."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showEditDialog(BuildContext context, Player player) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Edit"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit Player"),
      content: EditPlayerForm(player: player),
      actions: [
        cancelButton,
        // continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
      Row(children: <Widget>[
        GestureDetector(
            onTap: () => {onCheckboxClick(isChecked)},
            child: SizedBox(
                width: 960,
                child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 24.0, 0.0),
                            child: Checkbox(
                                value: isChecked, onChanged: onCheckboxClick),
                          ),
                          Text(
                              style: const TextStyle(fontSize: 16.0),
                              widget.player.toString()),
                        ]))))),
        TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => {showEditDialog(context, widget.player)},
            child: Text(style: TextStyle(color: Colors.white), "Edit")),
        Padding(padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0)),
        TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              showDeleteDialog(context, widget.player);
            },
            child: Text(style: TextStyle(color: Colors.white), "Delete")),
      ])
    ]);
  }
}
