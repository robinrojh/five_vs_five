import 'package:five_by_five/src/player/domain/player.dart';
import 'package:five_by_five/src/player/presentation/add_player_form.dart';
import 'package:five_by_five/src/player/presentation/player_card.dart';
import 'package:five_by_five/src/util/rank.dart';
import 'package:flutter/material.dart';

class PlayerCardList extends StatefulWidget {
  PlayerCardList(
      {required this.playerList,
      this.displayDelete = true,
      this.displayEdit = true,
      this.deleteFunction,
      required this.displayForm})
      : super(key: ObjectKey(playerList));

  final List<Player> playerList;
  final bool displayDelete;
  final bool displayEdit;
  final bool displayForm;
  final DeletePlayerFunction? deleteFunction;

  @override
  _PlayerCardListState createState() => _PlayerCardListState();
}

class _PlayerCardListState extends State<PlayerCardList> {
  List<Player> _selectedPlayerList = [];

  void handleCheckbox(bool isChecked, Player player) {
    if (isChecked) {
      _selectedPlayerList.add(player);
    } else {
      _selectedPlayerList.remove(player);
    }
  }

  void makeTeams() {
    if (_selectedPlayerList.length == 10) {
      Rank.getSubsetsWithSimilarPower(_selectedPlayerList, 4);
    } else {
      throw Exception("The team must consist 10 players exactly!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1280,
        child: Column(children: <Widget>[
          if (widget.displayForm) AddPlayerForm(),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.playerList.length,
              itemBuilder: (context, index) {
                return PlayerCard(
                  player: widget.playerList[index],
                  callback: handleCheckbox,
                  displayDelete: widget.displayDelete,
                  displayEdit: widget.displayEdit,
                  deleteFunction: widget.deleteFunction,
                );
              })
        ]));
  }
}
