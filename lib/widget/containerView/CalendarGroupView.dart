import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalendarGroupView extends StatelessWidget {
  CalendarGroupView({
    super.key,
    required this.selectedSegment,
    required this.groupInfoList,
    required this.selectedGroupInfoIndex,
    required this.onSelectedGroupInfoIndex,
  });

  SegmentedTypeEnum selectedSegment;
  List<GroupInfoClass> groupInfoList;
  int selectedGroupInfoIndex;
  Function(int) onSelectedGroupInfoIndex;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return SegmentedTypeEnum.todo == selectedSegment
        ? Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              height: 35,
              child: ScrollablePositionedList.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: groupInfoList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    GroupInfoClass group = groupInfoList[index];
                    ColorClass color = getColorClass(group.colorName);

                    Color selectedTextColor =
                        isLight ? Colors.white : color.s200;
                    Color selectedBgColor =
                        isLight ? color.s200 : darkButtonColor;

                    Color notSelectedTextColor =
                        isLight ? grey.original : Colors.white;
                    Color notSelectedBgColor =
                        isLight ? Colors.white : darkButtonColor;

                    return Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: Center(
                        child: CommonTag(
                          text: group.name,
                          fontSize: 14,
                          isBold: selectedGroupInfoIndex == index,
                          textColor: selectedGroupInfoIndex == index
                              ? selectedTextColor
                              : notSelectedTextColor,
                          bgColor: selectedGroupInfoIndex == index
                              ? selectedBgColor
                              : notSelectedBgColor,
                          onTap: () => onSelectedGroupInfoIndex(index),
                        ),
                      ),
                    );
                  }),
            ),
          )
        : const CommonNull();
  }
}
