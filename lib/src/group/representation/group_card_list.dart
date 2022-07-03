import 'package:five_by_five/src/group/domain/group.dart';
import 'package:five_by_five/src/group/representation/group_card.dart';
import 'package:flutter/material.dart';

class GroupCardList extends StatefulWidget {
  GroupCardList({required this.groupList})
      : super(key: ObjectKey(groupList));

  final List<Group> groupList;

  @override
  _GroupCardListState createState() => _GroupCardListState();
}

class _GroupCardListState extends State<GroupCardList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1280,
      child: Column(children: <Widget>[
      ListView.builder(
          shrinkWrap: true,
          itemCount: widget.groupList.length,
          itemBuilder: (context, index) {
            return GroupCard(
              group: widget.groupList[index],
            );
          })
    ]));
  }
}
