import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/main.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';

class UserMethod {
  String uid = auth.currentUser!.uid;

  Future<bool> addUser(UserInfoClass userInfo) async {
    await firestore.collection(usersCollection).doc(uid).set(userInfo.toJson());
    return true;
  }

  // Future<bool> getUser(UserInfoClass userInfo) async {

  // }
}
