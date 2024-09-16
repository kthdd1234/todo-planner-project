// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
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

    log(locale);
    DateTime now = DateTime.now();
    String userId = UniqueKey().hashCode.toString();
    String fontFamily = 'IM_Hyemin';
    String calendarFormat = CalendarFormat.week.toString();
    Map<String, dynamic> taskTitleInfo = {
      'title': locale == 'ko' ? '할 일 리스트' : 'Todo list',
      'colorName': "남색"
    };
    Map<String, dynamic> memoTitleInfo = {
      'title': locale == 'ko' ? '메모' : 'memo',
      'colorName': "주황색",
    };

    UserRepository().updateUser(
      UserBox(
        id: userId,
        createDateTime: now,
        calendarFormat: calendarFormat,
        language: locale,
        fontFamily: fontFamily,
        taskTitleInfo: taskTitleInfo,
        memoTitleInfo: memoTitleInfo,
        theme: 'light',
        filterIdList: filterIdList,
      ),
    );

    await UserRepository().user.save();
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
