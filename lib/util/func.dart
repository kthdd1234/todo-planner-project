import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';

SvgPicture svgAsset({
  required String name,
  required double width,
  Color? color,
}) {
  return SvgPicture.asset(
    'assets/svg/$name.svg',
    width: width,
    colorFilter:
        color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
  );
}

Color itemMarkColor({required Color groupColor, required String markType}) {
  if (markType == 'E') {
    return Colors.grey.shade400;
  }

  return {
    'O': Colors.green.shade100,
    'X': Colors.red.shade100,
    'M': Colors.orange.shade100,
    'T': Colors.purple.shade100,
  }[markType]!;
}

mdeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.MMMEd(locale).format(dateTime);
}

ColorClass getColor(String name) {
  return colorList.firstWhere((info) => info.colorName == name);
}

navigatorPop(context) {
  Navigator.of(context, rootNavigator: true).pop('dialog');
}
