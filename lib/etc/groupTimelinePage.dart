import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/util/class.dart';

class GroupTimelinePage extends StatelessWidget {
  const GroupTimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '타임라인'),
        body: const Column(
          children: [],
        ),
      ),
    );
  }
}
