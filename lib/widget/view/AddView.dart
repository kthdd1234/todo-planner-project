import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/page/FontPage.dart';
import 'package:project/page/HomePage.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:provider/provider.dart';

class AddView extends StatefulWidget {
  AddView({super.key, required this.groupInfo});

  GroupInfoClass groupInfo;

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool isShowInput = false;

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    bool isLight = context.watch<ThemeProvider>().isLight;
    String colorName = widget.groupInfo.colorName;
    ColorClass color = getColorClass(colorName);

    onInput(bool isShow) {
      setState(() => isShowInput = isShow);
    }

    onCompleted() async {
      onInput(false);
      FocusScope.of(context).unfocus();

      if (controller.text != '') {
        String groupId = widget.groupInfo.gid;
        String newTid = uuid();
        DateTime now = DateTime.now();

        widget.groupInfo.taskInfoList.add(
          TaskInfoClass(
            createDateTime: now,
            tid: newTid,
            name: controller.text,
            dateTimeType: taskDateTimeType.selection,
            dateTimeList: [selectedDateTime],
            recordInfoList: [],
          ),
        );

        await groupMethod.updateGroup(
          gid: groupId,
          groupInfo: widget.groupInfo,
        );

        setState(() => controller.text = '');
      }
    }

    return Column(
      children: [
        isShowInput
            ? TextFormField(
                scrollController: scrollController,
                controller: controller,
                autofocus: true,
                cursorColor: color.s400,
                style: TextStyle(
                  fontSize: 15,
                  color: isLight ? Colors.black : Colors.white,
                  fontWeight: isLight ? FontWeight.normal : FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: '할 일을 입력해주세요.'.tr(),
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: grey.s400,
                    fontWeight: isLight ? FontWeight.normal : FontWeight.bold,
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  ),
                ),
                onEditingComplete: onCompleted,
                onTapOutside: (_) => onCompleted(),
              )
            : InkWell(
                onTap: () => onInput(true),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      CommonText(
                        text: '+ 할 일 추가',
                        color: isLight ? color.original : Colors.white,
                        fontSize: 15,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: svgAsset(
                          name: 'mark-d',
                          width: 20,
                          color: isLight ? color.s100 : color.s200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        HorizentalBorder(colorName: colorName),
      ],
    );
  }
}
