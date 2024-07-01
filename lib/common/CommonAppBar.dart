import 'package:flutter/material.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/util/final.dart';
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
    return appBarList[bottomIdx];
  }
}
