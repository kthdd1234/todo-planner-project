import 'package:flutter/material.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/func.dart';

class TodoGroupItem extends StatelessWidget {
  TodoGroupItem({
    super.key,
    required this.text,
    required this.materialColor,
    required this.markType,
    this.isContinue,
    this.isHighlight,
    this.isShade50,
    this.memo,
  });

  String text, markType;
  String? memo;
  bool? isHighlight, isContinue, isShade50;
  MaterialColor materialColor;

  @override
  Widget build(BuildContext context) {
    onMark() {
      //
    }

    return Column(
      children: [
        CommonDivider(color: Colors.indigo.shade50),
        Row(
          children: [
            isContinue == true
                ? Expanded(
                    flex: 0,
                    child: CommonCircle(color: materialColor.shade200),
                  )
                : const CommonNull(),
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: text,
                      highlightColor:
                          isHighlight == true ? materialColor.shade50 : null,
                    ), //
                    CommonSpace(height: 2),
                    memo != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CommonSpace(width: 3),
                              svgAsset(
                                name: 'memo',
                                width: 10,
                                color: Colors.grey.shade400,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: CommonText(
                                  text: memo!,
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          )
                        : const CommonNull()
                  ],
                )),
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: CommonSvgButton(
                  name: 'mark-$markType',
                  color: isShade50 == true
                      ? materialColor.shade50
                      : materialColor.shade100,
                  width: 28,
                  onTap: onMark,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
