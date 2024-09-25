import 'dart:developer';

import 'package:project/main.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';

class TaskMethod {
  String uid = auth.currentUser!.uid;

  List<TaskInfoClass> getTaskInfoList(String gid) {
    List<TaskInfoClass> taskInfoList = [];

    firestore
        .collection(usersCollection)
        .doc(uid)
        .collection(groupsCollection)
        .doc(gid)
        .collection(tasksCollection)
        .get()
        .then((data) => log('$data'));

    // for (var element in collection) {}

    return [];
  }
}
