import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/modalSheet/TaskModalSheet.dart';

class SpeedDialButton extends StatelessWidget {
  const SpeedDialButton({super.key});

  onAddTodo(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TaskModalSheet(title: '할 일'),
    );
  }

  onAddRoutin(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TaskModalSheet(title: '루틴'),
    );
  }

  onAddMemo(context) {
    //
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
          onTap: () => onAddTodo(context),
        ),
        floatingAction(
          svg: 'routin',
          lable: '루틴 추가',
          color: teal,
          onTap: () => onAddRoutin(context),
        ),
        floatingAction(
          svg: 'pencil',
          lable: '메모 추가',
          color: orange,
          onTap: () => onAddTodo(context),
        ),
      ],
    );
  }
}
