// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/main.dart';
import 'package:project/provider/UserInfoProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/containerView/MainView.dart';
import 'package:provider/provider.dart';

class TaskBody extends StatelessWidget {
  const TaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;

    return StreamBuilder<QuerySnapshot>(
      stream: groupMethod.stream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CommonNull();

        List<GroupInfoClass> groupInfoList = groupMethod.getGroupInfoList(
          snapshot: snapshot,
        );
        groupInfoList = getGroupInfoOrderList(
          userInfo.groupOrderList,
          groupInfoList,
        );

        return MainView(groupInfoList: groupInfoList);
      },
    );
  }
}
