import 'package:flutter/material.dart';

class CommonDivider extends StatelessWidget {
  CommonDivider({super.key, required this.color});
  Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color, //Colors.grey.shade100
      height: 30,
      thickness: 0.5,
    );
  }
}
