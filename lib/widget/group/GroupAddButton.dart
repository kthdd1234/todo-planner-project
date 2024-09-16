import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';

class GroupAddButton extends StatelessWidget {
  GroupAddButton({super.key, required this.isLight, required this.onAdd});

  bool isLight;
  Function() onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        elevation: 0,
        foregroundColor: isLight ? Colors.black : Colors.white,
        backgroundColor: isLight ? Colors.white : darkContainerColor,
        onPressed: onAdd,
        icon: const Icon(Icons.add_rounded, size: 20),
        label: CommonText(text: '그룹 추가', fontSize: 14),
      ),
    );
  }
}
