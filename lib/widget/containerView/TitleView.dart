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
  TitleView({
    super.key,
    required this.title,
    required this.colorName,
    required this.isOpen,
    required this.onTitle,
    required this.onOpen,
  });

  String title, colorName;
  bool isOpen;
  Function(String, String) onTitle;
  Function() onOpen;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
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
              onTap: () => onTitle(title, colorName),
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
