import 'package:flutter/material.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';

class UserInfoProvider extends ChangeNotifier {
  UserInfoClass userInfo = initUserInfo;

  UserInfoClass get getUserInfo => userInfo;

  void changeUserInfo({required UserInfoClass newuUserInfo}) {
    userInfo = newuUserInfo;
    notifyListeners();
  }
}
