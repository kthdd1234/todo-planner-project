import 'package:flutter/material.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/button/ModalButton.dart';

class MemoModalSheet extends StatelessWidget {
  MemoModalSheet({
    super.key,
    required this.onEdit,
    required this.onRemove,
  });

  Function() onEdit, onRemove;

  @override
  Widget build(BuildContext context) {
    return CommonModalSheet(
      height: 150,
      child: Row(
        children: [
          ModalButton(
            svgName: 'highlighter',
            actionText: '메모 수정',
            color: textColor,
            onTap: onEdit,
          ),
          CommonSpace(width: 5),
          ModalButton(
            svgName: 'remove',
            actionText: '메모 삭제',
            color: red.s200,
            onTap: onRemove,
          ),
        ],
      ),
    );
  }
}
