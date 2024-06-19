import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int seletedIdx = context.watch<BottomTabIndexProvider>().seletedIdx;

    List<BottomNavigationBarItem> items = bottomNavigationBarItemList
        .map((item) => BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: svgAsset(
                  width: 27,
                  name:
                      '${item.svgAsset}-${seletedIdx == item.index ? "indigo" : 'grey'}',
                ),
              ),
              label: item.label,
            ))
        .toList();

    onBottomNavigation(int newIndex) {
      context
          .read<BottomTabIndexProvider>()
          .changeSeletedIdx(newIndex: newIndex);
    }

    return CommonBackground(
      child: CommonScaffold(
        body: bottomNavigationBarItemList[seletedIdx].body,
        isFab: seletedIdx == 0,
      ),
    );
  }
}


  // bottomNavigationBar: Theme(
        //   data: Theme.of(context).copyWith(
        //     canvasColor: Colors.transparent,
        //   ),
        //   child: BottomNavigationBar(
        //     items: items,
        //     elevation: 0,
        //     currentIndex: seletedIdx,
        //     selectedItemColor: textColor,
        //     onTap: onBottomNavigation,
        //   ),
        // ),