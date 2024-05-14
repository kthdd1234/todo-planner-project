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
  });

  String text, svgName;
  double svgWidth, fontSize;
  SvgDirection svgDirection;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [CommonText(text: text, fontSize: fontSize)];
    SvgPicture widget = svgAsset(name: svgName, width: svgWidth);

    svgDirection == SvgDirection.left
        ? children.insert(
            0,
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: widget,
            ))
        : children.add(Padding(
            padding: const EdgeInsets.only(left: 5),
            child: widget,
          ));

    return Row(children: children);
  }
}
