import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/repositories/user_repository.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/AddButton.dart';
import 'package:project/widget/button/TodayButton.dart';
import 'package:project/widget/button/TrackerButton.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CommonScaffold extends StatelessWidget {
  CommonScaffold(
      {super.key,
      required this.body,
      this.appBarInfo,
      this.bottomNavigationBar,
      this.isFab,
      this.resizeToAvoidBottomInset,
      this.backgroundColor});

  Widget? bottomNavigationBar;
  Widget body;
  AppBarInfoClass? appBarInfo;
  bool? resizeToAvoidBottomInset, isFab;
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBarInfo != null
          ? AppBar(
              title: CommonText(text: appBarInfo!.title, fontSize: 20),
              centerTitle: appBarInfo!.isCenter,
              actions: appBarInfo!.actions,
              backgroundColor: backgroundColor ?? Colors.transparent,
              scrolledUnderElevation: 0,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: body,
        ),
      ),
      // bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: Fab(isFab: isFab),
    );
  }
}

class Fab extends StatelessWidget {
  Fab({super.key, required this.isFab});

  bool? isFab;

  @override
  Widget build(BuildContext context) {
    return isFab == true
        ? MultiValueListenableBuilder(
            valueListenables: valueListenables,
            builder: (context, values, child) {
              DateTime selectedDateTime =
                  context.watch<SelectedDateTimeProvider>().seletedDateTime;
              bool isToday =
                  dateTimeKey(DateTime.now()) == dateTimeKey(selectedDateTime);
              UserBox? user = UserRepository().user;
              CalendarFormat calendarFormat =
                  calendarFormatInfo[user.calendarFormat]!;
              bool isNotMonth = calendarFormat != CalendarFormat.month;

              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isNotMonth
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              isToday
                                  ? const CommonNull()
                                  : const TodayButton(),
                              const TrackerButton(),
                            ],
                          ),
                        )
                      : const CommonNull(),
                  const AddButton(),
                ],
              );
            })
        : const CommonNull();
  }
}
