import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/util/final.dart';

class GroupRemoveButton extends StatelessWidget {
  GroupRemoveButton({
    super.key,
    required this.isEdit,
    required this.onRemove,
  });

  bool isEdit;
  Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return isEdit
        ? Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: onRemove,
              child: Icon(Icons.remove_circle, size: 20, color: red.s400),
            ),
          )
        : const CommonNull();
  }
}
