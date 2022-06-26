import 'package:five_by_five/src/player/data/repository/firestore_player_repository.dart';
import 'package:five_by_five/src/player/domain/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPlayerForm extends StatefulWidget {
  AddPlayerForm();

  _AddPlayerFormState createState() => _AddPlayerFormState();
}

class _AddPlayerFormState extends State<AddPlayerForm> {
  PlayerId playerId = "";
  String name = "";
  Rank currentRank = ["Silver", "1"];
  Rank highestRank = ["Silver", "1"];
  List<String> mainLanes = [];

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.centerLeft,
          child: Row(children: <Widget>[
            SizedBox(
                width: 624,
                child: TextFormField(
                  decoration:
                      InputDecoration(labelText: "League of Legends Nickname"),
                  validator: (id) {
                    if (id == null || id.isEmpty) {
                      return "Type in a valid ID please!";
                    }
                    return null;
                  },
                )),
            const Padding(padding: EdgeInsets.all(16.0)),
            SizedBox(
                width: 624,
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Name"),
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return "Type in a valid ID please!";
                    }
                    return null;
                  },
                ))
          ])),
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () => {}, child: Text("Add Player!"))))
    ]);
  }
}
