import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';

class HistoryTitle extends StatelessWidget {
  HistoryTitle({super.key, required this.isLight, required this.dateTime});

  bool isLight;
  DateTime dateTime;

  onMore() {
    //
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: ymdFullFormatter(locale: locale, dateTime: dateTime),
              fontSize: 13,
              isBold: !isLight,
            ),
            CommonSpace(height: 3),
            CommonText(
              text: eeeeFormatter(locale: locale, dateTime: dateTime),
              color: grey.original,
              fontSize: 12,
              isBold: !isLight,
            ),
          ],
        ),
        // InkWell(
        //   onTap: onMore,
        //   child: Padding(
        //     padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
        //     child: Icon(
        //       Icons.more_vert_rounded,
        //       size: 16,
        //       color: grey.original,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
