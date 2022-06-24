import 'package:five_by_five/src/player/domain/player.dart';
import 'package:five_by_five/src/team/domain/team.dart';
import 'package:flutter/cupertino.dart';

class TeamDashboard extends StatefulWidget {
  TeamDashboard({required this.playerList}) : super(key: ObjectKey(playerList));

  Map<PlayerId, PlayerPermissions> playerList;

  @override
  _TeamDashboardState createState() => _TeamDashboardState();
}

class _TeamDashboardState extends State<TeamDashboard> {
  @override
  Widget build(BuildContext context) {
    return Text("player");
  }
}
