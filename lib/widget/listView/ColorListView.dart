import 'package:flutter/material.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';

class ColorListView extends StatelessWidget {
  ColorListView({
    super.key,
    required this.selectedColorName,
    required this.onColor,
  });

  String selectedColorName;
  Function(String) onColor;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 30,
      child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: colorList
              .map(
                (color) => Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: GestureDetector(
                    onTap: () => onColor(color.colorName),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        CommonCircle(
                          color: isLight ? color.s100 : color.s300,
                          size: 30,
                        ),
                        selectedColorName == color.colorName
                            ? svgAsset(
                                name: 'mark-V',
                                width: 15,
                                color: isLight ? color.s300 : color.s50,
                              )
                            : const CommonNull(),
                      ],
                    ),
                  ),
                ),
              )
              .toList()),
    );
  }
}
