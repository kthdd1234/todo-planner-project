import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/func.dart';

class GroupMethod {
  String get uid => auth.currentUser!.uid;

  Stream<QuerySnapshot> stream() {
    return firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(groupsCollection)
        .snapshots();
  }

  Stream<QuerySnapshot> get groupSnapshots {
    return firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(groupsCollection)
        .snapshots();
  }

  List<GroupInfoClass> getGroupInfoList({required AsyncSnapshot snapshot}) {
    try {
      List<GroupInfoClass> groupInfoList = [];

      for (var doc in snapshot.data.docs) {
        groupInfoList.add(GroupInfoClass.fromJson(doc.data()));
      }

      return groupInfoList;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return [];
    }
  }

  Future<bool> addGroup({
    required String gid,
    required GroupInfoClass groupInfo,
  }) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(uid)
          .collection(groupsCollection)
          .doc(gid)
          .set(groupInfo.toJson());

      return true;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return false;
    }
  }

  Future<bool> updateGroup({
    required String gid,
    required GroupInfoClass groupInfo,
  }) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(uid)
          .collection(groupsCollection)
          .doc(gid)
          .update(groupInfo.toJson());

      return true;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return false;
    }
  }

  Future<bool> removeGroup({required String gid}) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(uid)
          .collection(groupsCollection)
          .doc(gid)
          .delete();

      return true;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return false;
    }
  }

  Future<bool> removeAllGroup({required List<String> groupIdList}) async {
    try {
      for (final groupId in groupIdList) {
        await removeGroup(gid: groupId);
      }

      return true;
    } catch (e) {
      errorMessage(msg: '알 수 없는 에러가 발생했어요');
      return false;
    }
  }
}
