import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';

class UserMethod {
  String uid = auth.currentUser!.uid;

  Stream<QuerySnapshot> stream() {
    return firestore.collection(usersCollection).snapshots();
  }

  Future<bool> addUser({required UserInfoClass userInfo}) async {
    await firestore.collection(usersCollection).doc(uid).set(userInfo.toJson());
    return true;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> get userSnapshots {
    return firestore.collection(usersCollection).doc(uid).snapshots();
  }

  // getUserInfo({required AsyncSnapshot snapshot}) {
  //   UserInfoClass usrInfo = initUserInfo;

  //   for (var doc in snapshot.data.docs) {
  //     usrInfo = UserInfoClass.fromJson(doc.data());
  //   }

  //   return usrInfo;
  // }
}
