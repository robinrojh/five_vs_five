import 'package:five_by_five/main.dart';
import 'package:five_by_five/src/player/data/repository/firestore_player_repository.dart';
import 'package:five_by_five/src/player/domain/player.dart';
import 'package:five_by_five/src/util/rank.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class EditPlayerForm extends StatefulWidget {
  EditPlayerForm({required this.player});

  Player player;

  _EditPlayerFormState createState() => _EditPlayerFormState();
}

class _EditPlayerFormState extends State<EditPlayerForm> {
  PlayerId playerId = "";
  String name = "";
  Rank currentRank = Rank(rank: ["Silver", "1"]);
  Rank highestRank = Rank(rank: ["Silver", "1"]);
  List<String> mainLanes = [];

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    Player givenPlayer = widget.player;
    playerId = givenPlayer.playerId;
    name = givenPlayer.name;
    currentRank = givenPlayer.currentRank;
    highestRank = givenPlayer.highestRank;
    mainLanes = givenPlayer.mainLanes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: Row(children: <Widget>[
              SizedBox(
                  width: 624,
                  child: TextFormField(
                    enabled: false,
                    readOnly: true,
                    initialValue: playerId,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        labelText: "League of Legends Nickname"),
                    validator: (playerId) {
                      if (playerId == null || playerId.isEmpty) {
                        return "Type in a valid ID please!";
                      }
                      return null;
                    },
                  )),
              const Padding(padding: EdgeInsets.all(16.0)),
              SizedBox(
                  width: 624,
                  child: TextFormField(
                    initialValue: name,
                    decoration: InputDecoration(labelText: "Name"),
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return "Type in a valid ID please!";
                      }
                      return null;
                    },
                    onChanged: (name) {
                      setState(() {
                        this.name = name;
                      });
                    },
                  ))
            ])),
        Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                SizedBox(
                    width: 624,
                    child: DropdownButtonFormField<Rank>(
                      value: currentRank,
                      validator: (chosenRank) {
                        if (chosenRank!.compareTo(highestRank) > 0) {
                          return "Current Rank cannot be higher than the highest rank!";
                        }
                        return null;
                      },
                      items: Rank.getRanksAsDropdownMenuItems(),
                      onChanged: (currentRank) {
                        setState(() {
                          this.currentRank = currentRank!;
                        });
                      },
                      decoration: InputDecoration(label: Text("Current Rank")),
                    )),
                const Padding(padding: EdgeInsets.all(16.0)),
                SizedBox(
                    width: 624,
                    child: DropdownButtonFormField<Rank>(
                      value: highestRank,
                      validator: (chosenRank) {
                        if (chosenRank!.compareTo(currentRank) < 0) {
                          return "Highest Rank cannot be lower than the current rank!";
                        }
                        return null;
                      },
                      items: Rank.getRanksAsDropdownMenuItems(),
                      onChanged: (highestRank) {
                        setState(() {
                          this.highestRank = highestRank!;
                        });
                      },
                      decoration: InputDecoration(label: Text("Highest Rank")),
                    ))
              ],
            )),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
              width: 624,
              child: MultiSelectFormField(
                title: const Text("Lanes"),
                initialValue: mainLanes,
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return 'Please select one or more options';
                  }
                  return null;
                },
                dataSource: const [
                  {"display": "Top", "value": "Top"},
                  {"display": "Jungle", "value": "Jungle"},
                  {"display": "Mid", "value": "Mid"},
                  {"display": "ADC", "value": "ADC"},
                  {"display": "Support", "value": "Support"},
                ],
                textField: 'display',
                valueField: 'value',
                onSaved: (value) {
                  if (value == null) return;
                  setState(() {
                    mainLanes = List<String>.from(value);
                  });
                },
              )),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Processing Data'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        Player newPlayer =
                            Player.createPlayer(<String, dynamic>{
                          "playerId": playerId,
                          "name": name,
                          "currentRank": currentRank.rank,
                          "highestRank": highestRank.rank,
                          "mainLanes": mainLanes,
                        });
                        // try {
                        FirestorePlayerRepository.editPlayer(
                                player: widget.player, editedPlayer: newPlayer)
                            .then((value) {
                          Navigator.of(context).pop();
                          return ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Player edited!"),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 1)),
                          );
                        }).catchError(((error, stackTrace) {
                          Navigator.of(context).pop();
                          return ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Editing Failed!"),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 1)),
                          );
                        }));
                      }
                    },
                    child: Text("Edit Player"))))
      ]),
    );
  }
}
