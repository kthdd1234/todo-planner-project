import 'package:flutter/material.dart';

class VerticalBorder extends StatelessWidget {
  VerticalBorder({
    super.key,
    required this.color,
    this.width,
    this.right,
  });

  Color color;
  double? width, right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: right ?? 10),
      child: Container(
        width: width ?? 5,
        height: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(2),
            bottom: Radius.circular(2),
          ),
        ),
      ),
    );
  }
}
