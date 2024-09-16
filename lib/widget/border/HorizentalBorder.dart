import 'package:flutter/material.dart';
import 'package:project/util/class.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';

import '../../provider/themeProvider.dart';

class HorizentalBorder extends StatelessWidget {
  HorizentalBorder({super.key, required this.colorName, this.height});

  String colorName;
  double? height;

  @override
  Widget build(BuildContext context) {
    ColorClass color = getColorClass(colorName);
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Container(
      width: double.infinity,
      height: height ?? (isLight ? 1 : 0.5),
      decoration: BoxDecoration(
        color: isLight ? color.s50 : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
