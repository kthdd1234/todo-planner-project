import 'package:flutter/material.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/final.dart';
import 'package:provider/provider.dart';

class CommonEmpty extends StatelessWidget {
  CommonEmpty({
    super.key,
    required this.height,
    required this.line_1,
    required this.line_2,
    this.onTap,
  });

  double height;
  String line_1, line_2;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    Color color = isLight ? grey.original : Colors.white;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonText(text: line_1, color: color, isBold: !isLight),
            CommonSpace(height: 2),
            CommonText(text: line_2, color: color, isBold: !isLight),
          ],
        ),
      ),
    );
  }
}
