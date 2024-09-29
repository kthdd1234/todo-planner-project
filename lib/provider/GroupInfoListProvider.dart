import 'package:flutter/material.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';

class GroupInfoListProvider extends ChangeNotifier {
  List<GroupInfoClass> groupInfoList = [];

  void changeGroupInfoList({required List<GroupInfoClass> newGroupInfoList}) {
    groupInfoList = newGroupInfoList;
    notifyListeners();
  }
}
