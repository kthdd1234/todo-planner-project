import 'package:flutter/material.dart';
import 'package:project/util/class.dart';

class GroupInfoListProvider extends ChangeNotifier {
  List<GroupInfoClass> groupInfoList = [];

  List<GroupInfoClass> get getGroupInfoList => groupInfoList;

  void changeGroupInfoList({required List<GroupInfoClass> newGroupInfoList}) {
    groupInfoList = newGroupInfoList;
    notifyListeners();
  }
}
