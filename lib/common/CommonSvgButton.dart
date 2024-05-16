import 'package:flutter/material.dart';
import 'package:project/util/class.dart';
import 'package:project/util/func.dart';

class CommonSvgButton extends StatelessWidget {
  CommonSvgButton({
    super.key,
    required this.name,
    required this.width,
    required this.color,
    required this.onTap,
  });

  String name;
  double width;
  Color color;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: svgAsset(
        name: name,
        width: width,
        color: color,
      ),
    );
  }
}
