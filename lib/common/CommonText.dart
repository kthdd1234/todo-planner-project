import 'package:flutter/material.dart';
import 'package:project/util/constants.dart';

class CommonText extends StatelessWidget {
  CommonText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.isNotTr,
    this.isBold,
    this.isRequired,
    this.highlightColor,
    this.nameArgs,
    this.onTap,
    this.textAlign,
    this.overflow,
  });

  String text;
  Color? color;
  double? fontSize;
  bool? isNotTr, isBold, isRequired;
  Color? highlightColor;
  Map<String, String>? nameArgs;
  TextAlign? textAlign;
  TextOverflow? overflow;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final basicText = Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.w400,
        overflow: overflow,
      ),
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(highlightColor != null ? 3 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: highlightColor,
        ),
        child: isRequired != true
            ? basicText
            : Row(children: [
                basicText,
                const Text(' *', style: TextStyle(color: Colors.red))
              ]),
      ),
    );
  }
}
