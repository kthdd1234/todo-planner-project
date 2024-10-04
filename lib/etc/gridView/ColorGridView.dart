import 'package:flutter/material.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';

class ColorGridView extends StatelessWidget {
  ColorGridView({
    super.key,
    required this.selectedColorName,
    required this.onTap,
  });

  String selectedColorName;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 10,
      ),
      children: colorList
          .map(
            (color) => GestureDetector(
              onTap: () => onTap(color.colorName),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CommonCircle(color: color.s100, size: 40),
                      selectedColorName == color.colorName
                          ? svgAsset(
                              name: 'mark-V',
                              width: 20,
                              color: Colors.white,
                            )
                          : const CommonNull(),
                    ],
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
