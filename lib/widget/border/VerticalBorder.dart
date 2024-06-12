import 'package:flutter/material.dart';

class VerticalBorder extends StatelessWidget {
  const VerticalBorder({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 5,
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
