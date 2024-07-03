import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/func.dart';

class CommonSvgText extends StatelessWidget {
  CommonSvgText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.svgWidth,
    required this.svgDirection,
    this.svgName,
    this.isBold,
    this.svgRight,
    this.svgLeft,
    this.svgColor,
    this.textColor,
    this.onTap,
  });

  String text;
  String? svgName;
  Color? textColor, svgColor;
  double svgWidth, fontSize;
  double? svgLeft, svgRight;
  bool? isBold;
  SvgDirectionEnum svgDirection;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      CommonText(
        text: text,
        fontSize: fontSize,
        isBold: isBold,
        color: textColor,
        overflow: TextOverflow.ellipsis,
      )
    ];
    // SvgPicture widget =

    svgDirection == SvgDirectionEnum.left
        ? svgName != null
            ? children.insert(
                0,
                Padding(
                  padding: EdgeInsets.only(right: svgRight ?? 5),
                  child: svgAsset(
                    name: svgName!,
                    width: svgWidth,
                    color: svgColor,
                  ),
                ))
            : const CommonNull()
        : svgName != null
            ? children.add(Padding(
                padding: EdgeInsets.only(left: svgLeft ?? 5, top: 1.5),
                child: svgAsset(
                  name: svgName!,
                  width: svgWidth,
                  color: svgColor,
                ),
              ))
            : const CommonNull();

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
