import 'package:five_by_five/src/player/domain/player.dart';
import 'package:five_by_five/src/player/presentation/add_player_form.dart';
import 'package:five_by_five/src/player/presentation/player_card.dart';
import 'package:five_by_five/src/player/presentation/team_card.dart';
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
  final List<Player> _selectedPlayerList = [];
  int _teamIndex = 0;
  List<List<Player>> _allTeams = [];
  List<Player> _team1 = [];
  List<Player> _team2 = [];
  void handleCheckbox(bool isChecked, Player player) {
    setState(() {
      if (isChecked) {
        _selectedPlayerList.add(player);
      } else {
        _selectedPlayerList.remove(player);
      }
    });
  }

  void makeTeams() {
    if (_selectedPlayerList.length == 10) {
      List<List<Player>> allTeams =
          Rank.getSubsetsWithSimilarPower(_selectedPlayerList, 4);
      setState(() {
        _allTeams = allTeams;
        _team1 = allTeams[0];
        _team2 = Rank.getOppositeTeam(allTeams[0], _selectedPlayerList);
      });
    } else {
      throw Exception("The team must consist 10 players exactly!");
    }
  }

  void getPreviousTeam() {
    if (_teamIndex > 0) {
      setState(() {
        _team1 = _allTeams[_teamIndex - 1];
        _team2 = Rank.getOppositeTeam(
            _allTeams[_teamIndex - 1], _selectedPlayerList);
        _teamIndex = _teamIndex - 1;
      });
    } else {
      int teamCount = _allTeams.length - 1;
      setState(() {
        _team1 = _allTeams[teamCount];
        _team2 =
            Rank.getOppositeTeam(_allTeams[teamCount], _selectedPlayerList);
        _teamIndex = teamCount;
      });
    }
  }

  void getNextTeam() {
    if (_teamIndex + 1 < _allTeams.length) {
      setState(() {
        _team1 = _allTeams[_teamIndex + 1];
        _team2 = Rank.getOppositeTeam(
            _allTeams[_teamIndex + 1], _selectedPlayerList);
        _teamIndex = _teamIndex + 1;
      });
    } else {
      setState(() {
        _team1 = _allTeams[0];
        _team2 = Rank.getOppositeTeam(_allTeams[0], _selectedPlayerList);
        _teamIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1280,
        child: Column(children: <Widget>[
          if (widget.displayForm) AddPlayerForm(),
          Center(
            child: ElevatedButton(
              child: Text("Make Team"),
              onPressed: makeTeams,
            ),
          ),
          Column(children: [
            if (!_allTeams.isEmpty)
              ElevatedButton(
                  onPressed: getPreviousTeam,
                  child:
                      Text("Previous  ${_teamIndex + 1}/${_allTeams.length}")),
            if (!_allTeams.isEmpty)
              ElevatedButton(
                  onPressed: getNextTeam,
                  child: Text("Next ${_teamIndex + 1}/${_allTeams.length}")),
            Row(
              children: [
                TeamCard(playerList: _team1),
                TeamCard(playerList: _team2)
              ],
            ),
          ]),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 8/2,
              mainAxisSpacing: 8,
              children: List.generate(widget.playerList.length,
                  (index) {
                return PlayerCard(
                  player: widget.playerList[index],
                  callback: handleCheckbox,
                  displayDelete: widget.displayDelete,
                  displayEdit: widget.displayEdit,
                  deleteFunction: widget.deleteFunction,
                );
              }),
            ),
          ),
        ]));
  }
}
