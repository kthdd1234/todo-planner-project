import 'package:flutter/material.dart';

class CommonBackground extends StatelessWidget {
  CommonBackground({super.key, required this.child, this.isRadius});

  bool? isRadius;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isRadius == true ? 10.0 : 0.0),
        image: const DecorationImage(
          image: AssetImage('assets/image/CloudyApple.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
