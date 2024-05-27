import 'package:flutter/material.dart';

class CommonCircle extends StatelessWidget {
  CommonCircle({super.key, required this.color, required this.size});

  Color color;
  double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
