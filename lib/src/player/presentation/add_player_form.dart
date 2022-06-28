import 'package:five_by_five/src/player/domain/player.dart';
import 'package:five_by_five/src/util/rank.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class AddPlayerForm extends StatefulWidget {
  AddPlayerForm();

  _AddPlayerFormState createState() => _AddPlayerFormState();
}

class _AddPlayerFormState extends State<AddPlayerForm> {
  PlayerId playerId = "";
  String name = "";
  Rank currentRank = Rank(rank: ["Silver", "2"]);
  Rank highestRank = Rank(rank: ["Silver", "1"]);
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
                  onChanged: (id) {
                    setState(() {
                      playerId = id;
                    });
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
                    items: Rank.getRanksAsDropdownMenuItems(),
                    onChanged: (currentRank) {
                      setState(() {
                        this.currentRank = currentRank!;
                      });
                    },
                    decoration: InputDecoration(labelText: "Current Rank"),
                  )),
              const Padding(padding: EdgeInsets.all(16.0)),
              SizedBox(
                  width: 624,
                  child: DropdownButtonFormField<Rank>(
                    items: Rank.getRanksAsDropdownMenuItems(),
                    onChanged: (highestRank) {
                      setState(() {
                        this.highestRank = highestRank!;
                      });
                    },
                    decoration: InputDecoration(labelText: "Highest Rank"),
                  ))
            ],
          )),
      Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
            width: 624,
            child: MultiSelectFormField(
              title: const Text("Lanes"),
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
                  mainLanes = value;
                });
              },
            )),
      ),
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () => {}, child: Text("Add Player!"))))
    ]);
  }
}
