import 'package:five_by_five/src/player/domain/player.dart';
import 'package:five_by_five/src/player/presentation/player_card.dart';
import 'package:flutter/cupertino.dart';

class TeamCard extends StatefulWidget {
  TeamCard({required this.playerList});

  final List<Player> playerList;

  @override
  State<StatefulWidget> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  @override
  Widget build(context) {
    return widget.playerList.isEmpty
        ? Container()
        : SizedBox(
            width: 600,
            height: 750,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: ((context, index) {
                  return PlayerCard(
                    player: widget.playerList[index],
                    callback: () {},
                    displayDelete: false,
                    displayEdit: false,
                    displayCheckBox: false,
                  );
                })));
  }
}
