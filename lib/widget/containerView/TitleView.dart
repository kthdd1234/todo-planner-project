import 'package:flutter/material.dart';
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
    required this.onTitle,
  });

  String title, colorName;
  Function(String, String) onTitle;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    ColorClass color = getColorClass(colorName);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              CommonTag(
                text: title,
                isNotTr: true,
                isBold: !isLight,
                textColor: isLight ? color.original : color.s200,
                bgColor: isLight ? color.s50 : darkButtonColor,
                innerPadding: const EdgeInsets.only(bottom: 5),
                onTap: () => onTitle(title, colorName),
              ),
              const Spacer(),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30,
                color: color.s100,
              )
            ],
          ),
        ),
        HorizentalBorder(colorName: '남색'),
      ],
    );
  }
}
