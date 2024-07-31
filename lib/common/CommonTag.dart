import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonText.dart';

class CommonTag extends StatelessWidget {
  CommonTag({
    super.key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    required this.onTap,
    this.innerPadding,
    this.isBold,
    this.isImage,
    this.fontSize,
    this.vertical,
    this.isNotTr,
  });

  String text;
  Color textColor, bgColor;
  bool? isBold, isNotTr;
  double? fontSize, vertical;
  EdgeInsets? innerPadding;
  bool? isImage;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: innerPadding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: vertical ?? 5, horizontal: 7),
          decoration: BoxDecoration(
            image: isImage == true
                ? const DecorationImage(
                    image: AssetImage('assets/image/t-4.png'),
                    fit: BoxFit.cover,
                  )
                : null,
            color: bgColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: CommonText(
            text: text,
            color: textColor,
            isBold: isBold,
            fontSize: fontSize,
            isNotTr: isNotTr,
          ),
        ),
      ),
    );
  }
}
