import 'package:flutter/material.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/final.dart';

class CommonModalItem extends StatelessWidget {
  CommonModalItem({
    super.key,
    required this.title,
    required this.child,
    required this.onTap,
  });

  String title;
  Widget child;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(text: title),
                    CommonSpace(width: 50),
                    child
                  ],
                ),
              ],
            ),
          ),
          CommonDivider(color: grey.s200, horizontal: 0),
        ],
      ),
    );
  }
}
