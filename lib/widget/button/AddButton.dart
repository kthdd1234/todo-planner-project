import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/page/MemoSettingPage.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/SpeedDialButton.dart';
import 'package:project/widget/modalSheet/TaskSettingModalSheet.dart';
import 'package:provider/provider.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
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
      activeBackgroundColor: red.s200,
      backgroundColor: indigo.s200,
      children: [
        speedDialChildButton(
          svg: 'plus',
          lable: '할 일 추가',
          color: indigo,
          onTap: () => onAddTodo(selectedDateTime),
        ),
        speedDialChildButton(
          svg: 'routin',
          lable: '루틴 추가',
          color: teal,
          onTap: () => onAddRoutin(selectedDateTime),
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
