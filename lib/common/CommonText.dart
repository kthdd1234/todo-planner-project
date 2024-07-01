import 'package:flutter/material.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:provider/provider.dart';

class CommonText extends StatelessWidget {
  CommonText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.isNotTr,
    this.isBold,
    this.highlightColor,
    this.nameArgs,
    this.onTap,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.decoration,
    this.decorationColor,
  });

  String text;
  Color? color;
  double? fontSize;
  bool? isNotTr, isBold;
  Color? highlightColor;
  Map<String, String>? nameArgs;
  TextAlign? textAlign;
  TextOverflow? overflow;
  bool? softWrap;
  TextDecoration? decoration;
  Color? decorationColor;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    Color defaultColor = isLight ? Colors.black : const Color(0xffDADDE0);

    return Container(
      padding: EdgeInsets.all(highlightColor != null ? 3 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: highlightColor,
      ),
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.center,
        softWrap: softWrap ?? true,
        style: TextStyle(
          color: color ?? defaultColor,
          fontSize: fontSize,
          fontWeight: isBold == true ? FontWeight.bold : FontWeight.w400,
          overflow: overflow,
          decoration: decoration,
          decorationColor: decorationColor,
        ),
      ),
    );
  }
}
