import 'package:flutter/material.dart';

class CommonDivider extends StatelessWidget {
  CommonDivider({super.key, this.color, this.horizontal, this.vertical});
  Color? color;
  double? horizontal, vertical;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ?? 0,
        vertical: vertical ?? 0,
      ),
      child: Divider(
        color: color ?? Colors.indigo.shade50,
        height: 0,
        thickness: 0.5,
      ),
    );
  }
}
