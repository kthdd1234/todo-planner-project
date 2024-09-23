import 'package:flutter/material.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:provider/provider.dart';

class CommonBackground extends StatelessWidget {
  CommonBackground({
    super.key,
    required this.child,
    this.isRadius,
    this.height,
    this.borderRadius,
    this.background,
  });

  bool? isRadius;
  double? height;
  BorderRadius? borderRadius;
  String? background;
  Widget child;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    String path = background ?? userRepository.user.background ?? '2';

    return Container(
      height: height ?? MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: isLight ? null : darkBgColor,
        borderRadius: borderRadius ??
            BorderRadius.circular(isRadius == true ? 10.0 : 0.0),
        image: isLight
            ? DecorationImage(
                image: AssetImage('assets/image/b-$path.png'),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: child,
    );
  }
}
