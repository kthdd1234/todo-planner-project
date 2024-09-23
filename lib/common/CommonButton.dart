import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';

class CommonButton extends StatelessWidget {
  CommonButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.buttonColor,
    required this.verticalPadding,
    required this.borderRadius,
    required this.onTap,
    this.fontSize,
    this.isBold,
    this.isNotTr,
    this.outerPadding,
    this.svg,
    this.isOutlined,
  });

  Color textColor, buttonColor;
  double verticalPadding, borderRadius;
  String text;
  EdgeInsetsGeometry? outerPadding;
  double? fontSize;
  bool? isBold, isNotTr, isOutlined;
  String? svg;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: verticalPadding),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: isOutlined == true
                        ? Border.all(width: 0.5, color: grey.s300)
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      svg != null
                          ? Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: svgAsset(name: svg!, width: 14),
                            )
                          : const CommonNull(),
                      CommonText(
                        fontSize: fontSize,
                        isNotTr: isNotTr,
                        text: text,
                        color: textColor,
                        isBold: isBold ?? true,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
