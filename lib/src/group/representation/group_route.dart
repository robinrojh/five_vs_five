import 'package:five_by_five/src/group/data/repository/firestore_group_repository.dart';
import 'package:five_by_five/src/group/domain/group.dart';
import 'package:five_by_five/src/group/representation/group_card_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupRoute extends StatefulWidget {
  GroupRoute();

  _GroupRouteState createState() => _GroupRouteState();
}

class _GroupRouteState extends State<GroupRoute> {
  bool _isLoading = true;
  List<Group> groupList = [];

  void _getGroups() async {
    List<Group> groupList = await FirestoreGroupRepository.getGroups();
    setState(() {
      this.groupList = groupList;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getGroups();
    super.initState();
  }

  @override
  Widget build(context) {
    if (!_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Groups"),
        ),
        body: GroupCardList(groupList: groupList),
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
