import 'package:flutter/material.dart';

class CommonDivider extends StatelessWidget {
  CommonDivider({super.key, this.color, this.horizontal});
  Color? color;
  double? horizontal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal ?? 20),
      child: Divider(
        color: color ?? Colors.indigo.shade50,
        height: 0,
        thickness: 0.5,
      ),
    );
  }
}
