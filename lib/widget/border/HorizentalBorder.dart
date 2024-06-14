import 'package:flutter/material.dart';

class HorizentalBorder extends StatelessWidget {
  HorizentalBorder({super.key, required this.color});

  Color color;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 3,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(3),
          bottom: Radius.circular(3),
        ),
      ),
    );
  }
}
