import 'package:flutter/material.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/group/GroupOrderButton.dart';
import 'package:project/widget/group/GroupRemoveButton.dart';
import 'package:provider/provider.dart';

class GroupItemButton extends StatelessWidget {
  GroupItemButton({
    super.key,
    required this.groupInfo,
    required this.isEdit,
    required this.onItem,
    required this.onRemove,
  });

  GroupInfoClass groupInfo;
  bool isEdit;
  Function(GroupInfoClass) onItem, onRemove;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    String colorName = groupInfo.colorName;
    ColorClass color = getColorClass(colorName);
    int count = groupInfo.taskInfoList.length;

    return Row(
      children: [
        GroupRemoveButton(isEdit: isEdit, onRemove: () => onRemove(groupInfo)),
        Expanded(
          child: InkWell(
            onTap: () => onItem(groupInfo),
            child: CommonContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonCircle(color: color.s200, size: 10),
                  CommonSpace(width: 10),
                  Expanded(
                    child: CommonText(
                      text: groupInfo.name,
                      isNotTr: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  CommonSpace(width: 30),
                  CommonSvgText(
                    text: '$count',
                    fontSize: 14,
                    textColor: isLight ? grey.original : Colors.white,
                    svgColor: isLight ? grey.original : Colors.white,
                    svgWidth: 6,
                    svgLeft: 6,
                    isNotTr: true,
                    svgDirection: SvgDirectionEnum.right,
                  )
                ],
              ),
            ),
          ),
        ),
        GroupOrderButton(isEdit: isEdit)
      ],
    );
  }
}
