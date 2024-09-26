import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/util/class.dart';
import 'package:project/widget/containerView/ContentView.dart';
import 'package:project/widget/containerView/AddView.dart';
import 'package:project/widget/containerView/TitleView.dart';

class GroupView extends StatelessWidget {
  GroupView({super.key, required this.groupInfo});

  GroupInfoClass groupInfo;

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 10),
      child: Column(
        children: [
          TitleView(groupInfo: groupInfo),
          groupInfo.isOpen
              ? Column(
                  children: [
                    ContentView(groupInfo: groupInfo),
                    AddView(groupInfo: groupInfo),
                  ],
                )
              : const CommonNull(),
        ],
      ),
    );
  }
}
