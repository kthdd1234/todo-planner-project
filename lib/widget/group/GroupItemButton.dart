import 'package:flutter/material.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/group_box/group_box.dart';
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
    required this.groupBox,
    required this.isEdit,
    required this.onItem,
    required this.onRemove,
  });

  GroupBox groupBox;
  bool isEdit;
  Function(GroupBox) onItem, onRemove;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    ColorClass color = getColorClass(groupBox.colorName);
    int count = taskRepository.taskList
        .where((task) => task.groupId == groupBox.id)
        .length;

    return Row(
      children: [
        GroupRemoveButton(isEdit: isEdit, onRemove: () => onRemove(groupBox)),
        Expanded(
          child: InkWell(
            onTap: () => onItem(groupBox),
            child: CommonContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonCircle(color: color.s200, size: 10),
                  CommonSpace(width: 10),
                  Expanded(
                    child: CommonText(
                      text: groupBox.name,
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
