import 'package:five_by_five/src/group/data/repository/firestore_group_repository.dart';
import 'package:five_by_five/src/group/domain/group.dart';
import 'package:five_by_five/src/player/presentation/player_card_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatefulWidget {
  GroupCard(
      {required this.group,
      this.displayDelete = true,
      this.displayEdit = false});

  final Group group;
  final bool displayDelete;
  final bool displayEdit;

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  onGroupCardClick() {
    print(widget.group);
  }

  showDeleteDialog(BuildContext context, Group group) {
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
        FirestoreGroupRepository.deleteGroup(groupId: group.groupId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm Delete?"),
      content: Text(
          "Are you sure you want to delete this group? This action is irreversible."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (widget.displayDelete) {
          return alert;
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Row(children: <Widget>[
        GestureDetector(
            onTap: () => {onGroupCardClick()},
            child: SizedBox(
                width: 1560,
                child: Card(
                    elevation: 5.0,
                    child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: <Widget>[
                            // ignore: avoid_unnecessary_containers
                            Container(
                                // width: double.infinity,
                                child: Text(
                              widget.group.title,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 32),
                            )),
                            PlayerCardList(
                              playerList: widget.group.playerList,
                              displayEdit: widget.displayEdit,
                              displayForm: false,
                              deleteFunction: (player) {
                                FirestoreGroupRepository.deleteFromGroup(
                                    groupId: widget.group.groupId,
                                    playerId: player.playerId);
                              },
                            ),
                          ],
                        ))))),
        Padding(padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0)),
        TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              showDeleteDialog(context, widget.group);
            },
            child: Text(style: TextStyle(color: Colors.white), "Delete")),
      ])
    ]);
  }
}
