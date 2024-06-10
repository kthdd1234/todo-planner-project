// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/repositories/user_repository.dart';
import 'package:project/util/final.dart';
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
    String userId = UniqueKey().hashCode.toString();
    String fontFamily = 'IM_Hyemin';
    String calendarFormat = CalendarFormat.week.toString();
    String taskTitle = '할 일, 루틴 리스트';

    UserRepository().updateUser(
      UserBox(
        id: userId,
        createDateTime: now,
        calendarFormat: calendarFormat,
        language: locale,
        fontFamily: fontFamily,
        taskTitle: taskTitle,
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
      child: CommonScaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
