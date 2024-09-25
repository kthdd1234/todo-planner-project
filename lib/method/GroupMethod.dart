import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';

class GroupMethod {
  String uid = auth.currentUser!.uid;

  Future<bool> addGroup(String gid, GroupInfoClass groupInfo) async {
    await firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(groupsCollection)
        .doc(gid)
        .set(groupInfo.toJson());

    return true;
  }

  List<GroupInfoClass> getGroupInfoList(AsyncSnapshot snapshot) {
    List<GroupInfoClass> groupInfoList = [];

    for (var doc in snapshot.data.docs) {
      groupInfoList.add(GroupInfoClass.fromJson(doc.data()));
    }

    return groupInfoList;
  }

  Stream<QuerySnapshot> stream() {
    return firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(groupsCollection)
        .snapshots();
  }
}
