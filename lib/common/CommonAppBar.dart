// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/HistoryOrderProvider.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/repositories/user_repository.dart';
import 'package:project/widget/appBar/AnalyzeAppBar.dart';
import 'package:project/widget/appBar/HistoryAppBar.dart';
import 'package:project/widget/appBar/SettingAppBar.dart';
import 'package:project/widget/appBar/TaskAppBar.dart';
import 'package:provider/provider.dart';

class CommonAppBar extends StatefulWidget {
  const CommonAppBar({super.key});

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    int bottomIdx = context.watch<BottomTabIndexProvider>().seletedIdx;

    List<Widget> appBarList = [
      TaskAppBar(),
      HistoryAppBar(),
      AnalyzeAppBar(),
      SettingAppBar()
    ];

    return appBarList[bottomIdx];
  }
}
