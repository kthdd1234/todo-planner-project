import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:provider/provider.dart';

class TitleView extends StatelessWidget {
  TitleView({super.key, required this.groupInfo});

  GroupInfoClass groupInfo;

  onTitle() {
    //
  }

  onOpen() {
    //
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    String title = groupInfo.name;
    bool isOpen = groupInfo.isOpen;
    String colorName = groupInfo.colorName;
    ColorClass color = getColorClass(colorName);

    return Column(
      children: [
        Row(
          children: [
            CommonTag(
              text: title,
              isNotTr: true,
              isBold: !isLight,
              textColor: isLight ? color.original : color.s200,
              bgColor: isLight ? color.s50 : darkButtonColor,
              onTap: onTitle,
            ),
            const Spacer(),
            InkWell(
              onTap: onOpen,
              child: svgAsset(
                name: '${isOpen ? 'open' : 'close'}-light',
                width: 20,
                color: color.s200,
              ),
            ),
            CommonSpace(width: 2)
          ],
        ),
        isOpen
            ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: HorizentalBorder(colorName: colorName),
              )
            : const CommonNull(),
      ],
    );
  }
}
