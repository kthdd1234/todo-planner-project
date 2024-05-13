import 'package:flutter/material.dart';
import 'package:project/util/constants.dart';

class CommonContainer extends StatelessWidget {
  CommonContainer({super.key, required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: null,
      height: null,
      padding: pagePadding,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 206, 206, 206).withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(2, 4),
            )
          ]),
      child: child,
    );
  }
}
