import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/final.dart';

class MemoLoading extends StatelessWidget {
  const MemoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: Row(
        children: [
          SizedBox(
            width: 10,
            height: 10,
            child: CircularProgressIndicator(
              color: orange.original,
              strokeWidth: 2,
            ),
          ),
          CommonSpace(width: 10),
          CommonText(text: '메모 저장 중...')
        ],
      ),
    );
  }
}
