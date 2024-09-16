import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/page/MemoSettingPage.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/SpeedDialButton.dart';
import 'package:project/widget/modalSheet/TaskSettingModalSheet.dart';
import 'package:provider/provider.dart';

class AddButton extends StatefulWidget {
  AddButton({super.key, required this.isLight});

  bool isLight;

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  speedDialChildButton({
    required String svg,
    required String lable,
    required ColorClass color,
    required Function() onTap,
  }) {
    return SpeedDialChild(
      shape: const CircleBorder(),
      child: svgAsset(
        name: svg,
        width: 15,
        color: widget.isLight ? Colors.white : color.s200,
      ),
      backgroundColor: widget.isLight ? color.s200 : darkButtonColor,
      labelWidget: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: CommonText(text: lable, color: Colors.white, isBold: true),
      ),
      onTap: onTap,
    );
  }

  onAddTodo(DateTime initDateTime) {
    tTodo.dateTimeList = [initDateTime];

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TaskSettingModalSheet(
        initTask: tTodo,
      ),
    );
  }

  // onAddRoutin(DateTime initDateTime) {
  //   tRoutin.dateTimeList = [initDateTime];

  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) => TaskSettingModalSheet(
  //       initTask: tRoutin,
  //     ),
  //   );
  // }

  onAddMemo(RecordBox? record, initDateTime) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => MemoSettingPage(
          recordBox: record,
          initDateTime: initDateTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    RecordBox? record =
        recordRepository.recordBox.get(dateTimeKey(selectedDateTime));

    return SpeedDialButton(
      icon: Icons.add,
      activeBackgroundColor: widget.isLight ? red.s200 : darkButtonColor,
      backgroundColor: widget.isLight ? Colors.white : darkButtonColor,
      children: [
        speedDialChildButton(
          svg: 'plus',
          lable: '할 일 추가',
          color: indigo,
          onTap: () => onAddTodo(selectedDateTime),
        ),
        speedDialChildButton(
          svg: 'pencil',
          lable: '메모 추가',
          color: orange,
          onTap: () => onAddMemo(record, selectedDateTime),
        ),
      ],
    );
  }
}
