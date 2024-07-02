import 'package:flutter/material.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/final.dart';
import 'package:provider/provider.dart';

class CommonModalItem extends StatelessWidget {
  CommonModalItem({
    super.key,
    required this.title,
    required this.child,
    required this.onTap,
  });

  String title;
  Widget child;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(text: title, isBold: !isLight),
                CommonSpace(width: 50),
                child
              ],
            ),
          ),
          CommonDivider(color: isLight ? grey.s200 : Colors.white12),
        ],
      ),
    );
  }
}
