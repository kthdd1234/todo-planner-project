import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/func.dart';

TableRow trackerItem({
  required bool isLight,
  required String text,
  required List<String?> markList,
  required ColorClass color,
}) {
  return TableRow(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        width: 160,
        height: 32,
        child: Center(
          child: CommonText(
            text: text,
            fontSize: 12,
            overflow: TextOverflow.ellipsis,
            isBold: !isLight,
            isNotTr: true,
          ),
        ),
      ),
      ...List.generate(
        7,
        (index) => Center(
          child: markList[index] != null
              ? svgAsset(
                  name: 'mark-${markList[index]}',
                  width: 14,
                  color: isLight ? color.s400 : color.s300,
                )
              : const CommonNull(),
        ),
      )
    ],
  );
}
