import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';

class CalendarMarkerView extends StatelessWidget {
  CalendarMarkerView({
    super.key,
    required this.day,
    required this.isLight,
    required this.color,
    required this.size,
    this.borderRadius,
  });

  String day;
  bool isLight;
  ColorClass color;
  double size;
  double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isLight ? color.s200 : color.s300,
          borderRadius: BorderRadius.circular(borderRadius ?? 100),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 0, top: 0),
          child: Center(
            child: CommonText(
              fontSize: 13,
              text: day,
              color: isLight ? Colors.white : color.s50,
              isBold: true,
              isNotTr: true,
            ),
          ),
        ),
      ),
    );
  }
}
