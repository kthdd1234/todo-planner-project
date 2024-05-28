import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';

class CommonScaffold extends StatelessWidget {
  CommonScaffold({
    super.key,
    required this.body,
    this.appBarInfo,
    this.bottomNavigationBar,
    this.isFab,
    this.resizeToAvoidBottomInset,
  });

  Widget? bottomNavigationBar;
  Widget body;
  AppBarInfoClass? appBarInfo;
  bool? resizeToAvoidBottomInset, isFab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBarInfo != null
          ? AppBar(
              title: CommonText(text: appBarInfo!.title, fontSize: 20),
              centerTitle: appBarInfo!.isCenter,
              actions: appBarInfo!.actions,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: body,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: isFab == true ? const FloatingAction() : null,
    );
  }
}

class FloatingAction extends StatelessWidget {
  const FloatingAction({super.key});

  onAddTodo(context) {
    Navigator.pushNamed(context, 'todo-add-page');
  }

  onAddRoutin(context) {
    //
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


  //  showModalBottomSheet(
  //     context: context,
  //     builder: (context) => CommonModalSheet(
  //       title: '카테고리 선택',
  //       height: 400,
  //       child: Column(
  //         children: [
  //           Expanded(
  //             child: CommonContainer(
  //               child: Wrap(
  //                 alignment: WrapAlignment.start,
  //                 children: [
  //                   Column(
  //                     children: [
  //                       CommonButton(
  //                         text: '📚독서',
  //                         textColor: blue.original,
  //                         buttonColor: blue.s50,
  //                         verticalPadding: 15,
  //                         borderRadius: 7,
  //                         isBold: false,
  //                         onTap: () {
  //                           //
  //                         },
  //                       )
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           CommonSpace(height: 15),
  //           CommonButton(
  //             text: '카테고리 추가',
  //             textColor: Colors.white,
  //             buttonColor: indigo.s200,
  //             verticalPadding: 15,
  //             borderRadius: 7,
  //             onTap: () {
  //               //
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );