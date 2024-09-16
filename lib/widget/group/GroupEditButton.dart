import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/final.dart';

class GroupEditButton extends StatelessWidget {
  GroupEditButton({
    super.key,
    required this.isEdit,
    required this.isLight,
    required this.onEdit,
  });

  bool isEdit, isLight;
  Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onEdit,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CommonText(
          text: isEdit ? '편집 해제' : '편집',
          color: isEdit
              ? red.s300
              : isLight
                  ? grey.original
                  : grey.s400,
        ),
      ),
    );
  }
}
