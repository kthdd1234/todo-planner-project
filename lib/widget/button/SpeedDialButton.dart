import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/page/MemoSettingPage.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/modalSheet/TaskSettingModalSheet.dart';
import 'package:provider/provider.dart';

class SpeedDialButton extends StatefulWidget {
  const SpeedDialButton({super.key});

  @override
  State<SpeedDialButton> createState() => _SpeedDialButtonState();
}

class _SpeedDialButtonState extends State<SpeedDialButton> {
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

  onAddRoutin(DateTime initDateTime) {
    tRoutin.dateTimeList = [initDateTime];

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TaskSettingModalSheet(
        initTask: tRoutin,
      ),
    );
  }

  onAddMemo(RecordBox? record, initDateTime) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => MemoSettingPage(
          initDateTime: initDateTime,
        ),
      ),
    );
  }

  floatingAction({
    required String svg,
    required String lable,
    required ColorClass color,
    required Function() onTap,
  }) {
    return SpeedDialChild(
      shape: const CircleBorder(),
      child: svgAsset(name: svg, width: 15, color: Colors.white),
      backgroundColor: color.s200,
      labelWidget: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: CommonText(text: lable, color: Colors.white, isBold: true),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    RecordBox? record =
        recordRepository.recordBox.get(dateTimeKey(selectedDateTime));

    return SpeedDial(
      icon: Icons.add,
      spacing: 3,
      buttonSize: const Size(47, 47),
      childrenButtonSize: const Size(47, 47),
      spaceBetweenChildren: 7,
      iconTheme: const IconThemeData(color: Colors.white, size: 30),
      activeIcon: Icons.close,
      activeBackgroundColor: red.s200,
      elevation: 0,
      visible: true,
      overlayOpacity: 0.4,
      overlayColor: Colors.black87,
      backgroundColor: indigo.s200,
      children: [
        floatingAction(
          svg: 'plus',
          lable: '할 일 추가',
          color: indigo,
          onTap: () => onAddTodo(selectedDateTime),
        ),
        floatingAction(
          svg: 'routin',
          lable: '루틴 추가',
          color: teal,
          onTap: () => onAddRoutin(selectedDateTime),
        ),
        floatingAction(
          svg: 'pencil',
          lable: '메모 추가',
          color: orange,
          onTap: () => onAddMemo(record, selectedDateTime),
        ),
      ],
    );
  }
}
