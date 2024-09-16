import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/group/GroupOrderButton.dart';
import 'package:project/widget/group/GroupRemoveButton.dart';

class GroupItemButton extends StatelessWidget {
  GroupItemButton({
    super.key,
    required this.isEdit,
    required this.onItem,
    required this.onRemove,
  });

  bool isEdit;
  Function() onItem, onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GroupRemoveButton(isEdit: isEdit, onRemove: onRemove),
        Expanded(
          child: InkWell(
            onTap: onItem,
            child: CommonContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CommonText(
                      text: '국어',
                      isNotTr: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  // CommonSpace(width: 30),
                  // CommonSvgText(
                  //   text: '${widget.count}',
                  //   fontSize: 14,
                  //   textColor: isLight ? grey.original : Colors.white,
                  //   svgColor: isLight ? grey.original : Colors.white,
                  //   svgWidth: 6,
                  //   svgLeft: 6,
                  //   isNotTr: true,
                  //   svgDirection: SvgDirectionEnum.right,
                  // )
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
