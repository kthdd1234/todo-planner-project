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
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}