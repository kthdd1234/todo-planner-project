import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/ModalButton.dart';
import 'package:provider/provider.dart';

class MemoModalSheet extends StatelessWidget {
  MemoModalSheet({
    super.key,
    required this.selectedDateTime,
    required this.onEdit,
    required this.onRemove,
  });

  DateTime selectedDateTime;
  Function() onEdit, onRemove;

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonModalSheet(
      title: ymdeFormatter(locale: locale, dateTime: selectedDateTime),
      height: 185,
      child: Column(
        children: [
          Row(
            children: [
              ModalButton(
                svgName: 'highlighter',
                actionText: '메모 수정',
                color: isLight ? textColor : darkTextColor,
                isBold: !isLight,
                onTap: onEdit,
              ),
              CommonSpace(width: 5),
              ModalButton(
                svgName: 'remove',
                actionText: '메모 삭제',
                color: red.s200,
                isBold: !isLight,
                onTap: onRemove,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
