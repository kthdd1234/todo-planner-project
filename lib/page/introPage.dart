// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/repositories/user_repository.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:table_calendar/table_calendar.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  onStart() async {
    String locale = context.locale.toString();

    DateTime now = DateTime.now();
    String userId = uuid();
    String groupId = uuid();
    String fontFamily = 'IM_Hyemin';
    String calendarFormat = CalendarFormat.week.toString();

    groupRepository.updateGroup(
      key: groupId,
      group: GroupBox(
        createDateTime: now,
        id: groupId,
        name: getGroupName(locale),
        colorName: '남색',
        isOpen: true,
      ),
    );

    userRepository.updateUser(
      UserBox(
        id: userId,
        createDateTime: now,
        calendarFormat: calendarFormat,
        language: locale,
        fontFamily: fontFamily,
        taskTitleInfo: {},
        memoTitleInfo: {},
        theme: 'light',
        filterIdList: filterIdList,
        groupOrderList: [groupId],
      ),
    );

    await Navigator.pushNamedAndRemoveUntil(
      context,
      'home-page',
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      background: '0',
      child: CommonScaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            svgAsset(name: 'todo-planner-app-icon', width: 80),
            CommonSpace(height: 20),
            CommonText(text: '반가워요! 투두 트래커와 함께', color: textColor),
            CommonSpace(height: 2),
            CommonText(text: '오늘의 할 일을 실천해봐요 :D', color: textColor),
            const Spacer(),
            CommonButton(
              outerPadding: const EdgeInsets.symmetric(horizontal: 10),
              text: '시작하기',
              textColor: Colors.white,
              buttonColor: indigo.s200,
              verticalPadding: 15,
              borderRadius: 7,
              onTap: onStart,
            )
          ],
        ),
      ),
    );
  }
}
