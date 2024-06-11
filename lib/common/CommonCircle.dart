import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonCircle extends StatelessWidget {
  CommonCircle({
    super.key,
    required this.color,
    required this.size,
    this.padding,
  });

  Color color;
  double size;
  EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
