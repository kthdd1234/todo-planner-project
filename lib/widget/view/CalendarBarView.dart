import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/widget/border/VerticalBorder.dart';
import 'package:provider/provider.dart';

class CalendarBarView extends StatelessWidget {
  CalendarBarView({
    super.key,
    this.highlighterColor,
    required this.color,
    required this.name,
  });

  ColorClass color;
  Color? highlighterColor;
  String name;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Container(
          decoration: BoxDecoration(
            color: highlighterColor,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 0,
                child: VerticalBorder(
                  width: 2,
                  right: 3,
                  color: isLight ? color.s200 : color.s300,
                ),
              ),
              Flexible(
                child: CommonText(
                  text: name,
                  overflow: TextOverflow.clip,
                  isBold: !isLight,
                  fontSize: 9,
                  softWrap: false,
                  textAlign: TextAlign.start,
                  isNotTr: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
