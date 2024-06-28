import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/func.dart';

class CommonSvgText extends StatelessWidget {
  CommonSvgText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.svgName,
    required this.svgWidth,
    required this.svgDirection,
    this.isBold,
    this.svgRight,
    this.svgLeft,
    this.svgColor,
    this.textColor,
    this.onTap,
  });

  String text, svgName;
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
    SvgPicture widget = svgAsset(
      name: svgName,
      width: svgWidth,
      color: svgColor,
    );

    svgDirection == SvgDirectionEnum.left
        ? children.insert(
            0,
            Padding(
              padding: EdgeInsets.only(right: svgRight ?? 5),
              child: widget,
            ))
        : children.add(Padding(
            padding: EdgeInsets.only(left: svgLeft ?? 5, top: 1.5),
            child: widget,
          ));

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
