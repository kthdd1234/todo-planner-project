import 'package:flutter/material.dart';

class CommonDivider extends StatelessWidget {
  CommonDivider({super.key, this.color});
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Colors.indigo.shade50, //Colors.grey.shade100
      height: 0,
      thickness: 0.5,
    );
  }
}
