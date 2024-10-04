import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';

TableRow trackerTitle({
  required bool isLight,
  required String title,
  required ColorClass color,
}) {
  return TableRow(
    children: <Widget>[
      SizedBox(
        width: 160,
        height: 32,
        child: Center(
          child: CommonText(
            text: title,
            fontSize: 12,
            overflow: TextOverflow.ellipsis,
            color: isLight ? color.original : color.s300,
            isBold: !isLight,
            isNotTr: true,
          ),
        ),
      ),
      ...days.map(
        (day) => Center(
          child: CommonText(
            text: day,
            fontSize: 12,
            color: isLight ? grey.original : grey.s400,
            isBold: !isLight,
          ),
        ),
      )
    ],
  );
}
