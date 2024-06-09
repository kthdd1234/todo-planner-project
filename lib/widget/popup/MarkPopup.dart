import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonOutlineInputField.dart';
import 'package:project/common/CommonPopup.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/modalSheet/MemoModalSheet.dart';

class MarkPopup extends StatefulWidget {
  MarkPopup({super.key, required this.taskId});

  String taskId;

  @override
  State<MarkPopup> createState() => _MarkPopupState();
}

class _MarkPopupState extends State<MarkPopup> {
  TextEditingController controller = TextEditingController();
  bool isShowInput = true;
  bool isAutoFocus = false;

  @override
  void initState() {
    controller.text =
        '가나다라마바사아차카바아랴하니야미끼끼립쭝123123123아브라카다브라어ㅣ마너아ㅣ머이ㅏㅁ너ㅏㅣ엄나ㅣ어ㅣㅏㅁ임너이ㅏ머엄나ㅣ엄나ㅣ어ㅏㅣㅁ너아ㅣㅁ너아ㅣ머ㅏㅣ어마ㅣ어ㅏㅣ머아ㅣㅁ너아ㅣㅁ너아ㅣ머나ㅣ엄나ㅣ어ㅏㅣㅁ너아ㅣㅁ너아ㅣㅓㅂ젇ㅂ재댜ㅐㅔㅈ뱌대ㅔ뱌재ㅔ댜대ㅔ뱌재ㅔㄷ뱌ㅐㅔㅑㅔ';

    super.initState();
  }

  onMark() {
    navigatorPop(context);
  }

  onMemo() {
    showModalBottomSheet(
      context: context,
      builder: (context) => MemoModalSheet(
        onEdit: () {
          setState(() {
            isShowInput = true;
            isAutoFocus = true;
          });
          navigatorPop(context);
        },
        onRemove: () {
          setState(() {
            isShowInput = true;
            isAutoFocus = false;
          });
          navigatorPop(context);
        },
      ),
    );
  }

  onEditingComplete() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return CommonPopup(
      insetPaddingHorizontal: 50,
      height: 375,
      child: CommonContainer(
        innerPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Column(
              children: markList
                  .map((info) => MarkItem(
                        isSelected: info['svg'] == 'O',
                        svg: info['svg'],
                        name: info['name'],
                        colorName: '파란색',
                        onTap: () => onMark(),
                      ))
                  .toList(),
            ),
            Padding(
              padding: EdgeInsets.only(top: isShowInput ? 20 : 10),
              child: isShowInput
                  ? CommonOutlineInputField(
                      autofocus: isAutoFocus,
                      hintText: '메모 입력하기',
                      controller: controller,
                      onEditingComplete: onEditingComplete,
                    )
                  : CommonText(
                      text: controller.text,
                      onTap: onMemo,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class MarkItem extends StatelessWidget {
  MarkItem({
    super.key,
    required this.svg,
    required this.name,
    required this.colorName,
    required this.isSelected,
    required this.onTap,
  });

  String svg, name, colorName;
  bool isSelected;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CommonSpace(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 75),
            decoration: BoxDecoration(
              color: isSelected ? getColor(colorName).s50 : null,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: svgAsset(
                    name: 'mark-$svg',
                    width: 15,
                    color: blue.s200,
                  ),
                ),
                CommonSpace(width: 10),
                Expanded(
                  flex: 0,
                  child: CommonText(
                    text: name,
                    fontSize: 15,
                    color: textColor,
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          ),
          CommonSpace(height: 10),
          CommonDivider(horizontal: 0)
        ],
      ),
    );
  }
}
