import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonContainer extends StatelessWidget {
  CommonContainer({
    super.key,
    required this.child,
    this.innerPadding,
    this.outerPadding,
    this.color,
    this.radius,
    this.onTap,
    this.height,
  });

  Widget child;
  Color? color;
  double? radius, height;
  EdgeInsets? innerPadding, outerPadding;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: height,
          padding: innerPadding ?? const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: color ?? Colors.white,
              borderRadius: BorderRadius.circular(radius ?? 10),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 206, 206, 206).withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(2, 4),
                )
              ]),
          child: child,
        ),
      ),
    );
  }
}
