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
    this.markType,
    this.isContinue,
    this.isHighlight,
    this.isShade50,
    this.memo,
    this.isShowMark,
  });

  String text;
  String? memo, markType;
  bool? isHighlight, isContinue, isShade50, isShowMark;
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
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CommonCircle(
                      color: materialColor.shade100,
                      size: 15,
                    ),
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
            isShowMark != false
                ? Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: CommonSvgButton(
                        name: 'mark-$markType',
                        color: itemMarkColor(
                          groupColor: materialColor,
                          markType: markType!,
                        ),
                        width: 28,
                        onTap: onMark,
                      ),
                    ),
                  )
                : const CommonNull(),
          ],
        ),
      ],
    );
  }
}
