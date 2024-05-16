import 'package:flutter/material.dart';

class CommonCircle extends StatelessWidget {
  const CommonCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: Colors.indigo.shade100,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
