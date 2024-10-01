import 'package:flutter/material.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/button/ModalButton.dart';
import 'package:provider/provider.dart';

class ThemeModalSheet extends StatelessWidget {
  ThemeModalSheet({
    super.key,
    required this.title,
    required this.theme,
    required this.onTap,
  });

  String title, theme;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeProvider>().isLight;

    button({required String id, required String name}) {
      bool isSelected = theme == id;

      Color buttonTextColor = isLight
          ? isSelected
              ? Colors.white
              : grey.original
          : isSelected
              ? Colors.white
              : grey.s300;

      Color buttonBgColor = isLight
          ? isSelected
              ? textColor
              : Colors.white
          : isSelected
              ? textColor
              : darkContainerColor;

      return ModalButton(
        svgName: id,
        actionText: name,
        isBold: isSelected,
        color: buttonTextColor,
        bgColor: buttonBgColor,
        onTap: () => onTap(id),
      );
    }

    return CommonModalSheet(
      title: title,
      height: 190,
      child: Row(
        children: [
          button(id: 'light', name: '밝은 테마'),
          CommonSpace(width: 5),
          button(id: 'dark', name: '어두운 테마'),
        ],
      ),
    );
  }
}
