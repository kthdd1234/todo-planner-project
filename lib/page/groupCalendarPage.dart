import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/util/class.dart';

class GroupCalendarPage extends StatelessWidget {
  const GroupCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          title: '캘린더',
          actions: [],
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
