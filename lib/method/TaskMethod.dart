import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/func.dart';

class TaskMethod {
  String uid = auth.currentUser!.uid;

  Stream<QuerySnapshot> stream({required String gid}) {
    return firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(groupsCollection)
        .doc(gid)
        .collection(tasksCollection)
        .snapshots();
  }

  List<TaskInfoClass> getTaskInfoList({
    required String gid,
    required AsyncSnapshot snapshot,
  }) {
    List<TaskInfoClass> taskInfoList = [];

    for (var doc in snapshot.data.docs) {
      taskInfoList.add(TaskInfoClass.fromJson(doc.data()));
    }

    return taskInfoList;
  }

  Future<bool> addTask({
    required String gid,
    required String tid,
    required TaskInfoClass taskInfo,
  }) async {
    await firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(groupsCollection)
        .doc(gid)
        .collection(tasksCollection)
        .doc(tid)
        .set(taskInfo.toJson());

    return true;
  }

  Future<bool> updateTask({
    required String gid,
    required String tid,
    required TaskInfoClass taskInfo,
  }) async {
    await firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(groupsCollection)
        .doc(gid)
        .collection(tasksCollection)
        .doc(tid)
        .update(taskInfo.toJson());

    return true;
  }

  Future<bool> deleteTask({
    required String gid,
    required String tid,
    required GroupInfoClass groupInfo,
    required DateTime dateTime,
  }) async {
    final groupRef = firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(groupsCollection)
        .doc(gid);
    final taskRef = groupRef.collection(tasksCollection).doc(tid);

    // task 삭제
    await taskRef.delete();

    /// task order id 삭제
    int index = groupInfo.taskOrderList.indexWhere(
      (taskOrder) => taskOrder['dateTimeKey'] == dateTimeKey(dateTime),
    );

    if (index != -1) {
      groupInfo.taskOrderList[index]['list'].remove(tid);
      await groupRef.update(groupInfo.toJson());
    }

    return true;
  }
}
