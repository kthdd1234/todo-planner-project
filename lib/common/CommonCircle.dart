import 'package:flutter/material.dart';

class CommonCircle extends StatelessWidget {
  CommonCircle({super.key, required this.color, required this.size});

  Color color;
  double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
