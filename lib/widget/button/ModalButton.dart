import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/func.dart';

class ModalButton extends StatelessWidget {
  ModalButton({
    super.key,
    required this.actionText,
    required this.color,
    required this.onTap,
    this.icon,
    this.svgName,
    this.bgColor,
    this.isBold,
    this.innerPadding,
  });

  String? svgName;
  IconData? icon;
  String actionText;
  Color color;
  Color? bgColor;
  bool? isBold;
  EdgeInsets? innerPadding;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: innerPadding ?? const EdgeInsets.all(0),
        child: CommonContainer(
          color: bgColor,
          onTap: onTap,
          radius: 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svgName != null
                  ? svgAsset(name: svgName!, width: 25, color: color)
                  : const CommonNull(),
              icon != null
                  ? Icon(icon!, size: 25, color: color)
                  : const CommonNull(),
              CommonSpace(height: 10),
              CommonText(text: actionText, color: color, isBold: isBold)
            ],
          ),
        ),
      ),
    );
  }
}
