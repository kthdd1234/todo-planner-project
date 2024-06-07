import 'package:flutter/material.dart';

class IconButton2 extends StatelessWidget {
  IconButton2({
    super.key,
    required this.size,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
    this.backgroundColorOpacity,
  });

  double size;
  IconData icon;
  Color backgroundColor;
  Color iconColor;
  double? backgroundColorOpacity;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(backgroundColorOpacity ?? 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(
            icon,
            size: size,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

// 45
// 45
// 10
// Icons.time_to_leave
