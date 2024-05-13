import 'package:flutter/material.dart';

class CommonBackground extends StatelessWidget {
  CommonBackground({super.key, required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/CloudyApple.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
