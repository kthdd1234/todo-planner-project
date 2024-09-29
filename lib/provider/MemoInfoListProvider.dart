import 'package:flutter/material.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';

class MemoInfoListProvider extends ChangeNotifier {
  List<MemoInfoClass> memoInfoList = [];

  void changeMemoInfoList({required List<MemoInfoClass> newMemoInfoList}) {
    memoInfoList = newMemoInfoList;
    notifyListeners();
  }
}
