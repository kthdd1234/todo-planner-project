import 'package:flutter/material.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:provider/provider.dart';

class DateTimeButton extends StatelessWidget {
  DateTimeButton({
    super.key,
    required this.color,
    required this.text,
    required this.type,
    required this.selectedType,
    required this.onTap,
  });

  ColorClass color;
  String text, type, selectedType;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isSelectedType = selectedType == type;

    Color notTextColor = isLight ? grey.s400 : Colors.white;
    Color notBgColor = isLight ? whiteBgBtnColor : darkNotSelectedBgColor;

    Color textColor = isSelectedType ? color.s50 : notTextColor;
    Color buttonColor = isSelectedType
        ? isLight
            ? color.s200
            : color.s300
        : notBgColor;

    return Expanded(
      child: CommonButton(
        text: text,
        fontSize: 13,
        isBold: isSelectedType,
        textColor: textColor,
        buttonColor: buttonColor,
        verticalPadding: 10,
        borderRadius: 5,
        onTap: () => onTap(type),
      ),
    );
  }
}
