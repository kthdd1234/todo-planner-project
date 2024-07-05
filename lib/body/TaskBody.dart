// ignore_for_file: prefer_const_constructors
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/ad/BannerAd.dart';
import 'package:project/widget/appBar/TaskAppBar.dart';
import 'package:project/widget/container/MemoContainer.dart';
import 'package:project/widget/container/TaskContainer.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskBody extends StatefulWidget {
  const TaskBody({super.key});

  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<SelectedDateTimeProvider>()
          .changeSelectedDateTime(dateTime: DateTime.now());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    RefreshController refreshController = RefreshController();

    onHorizontalDragEnd(DragEndDetails dragEndDetails) {
      double? primaryVelocity = dragEndDetails.primaryVelocity;

      if (primaryVelocity == null) {
        return;
      } else if (primaryVelocity > 0) {
        selectedDateTime = selectedDateTime.subtract(Duration(days: 1));
      } else if (primaryVelocity < 0) {
        selectedDateTime = selectedDateTime.add(Duration(days: 1));
      }

      context
          .read<SelectedDateTimeProvider>()
          .changeSelectedDateTime(dateTime: selectedDateTime);
      context
          .read<TitleDateTimeProvider>()
          .changeTitleDateTime(dateTime: selectedDateTime);
    }

    onRefresh() async {
      refreshController.refreshCompleted();

      UserBox user = userRepository.user;
      user.calendarFormat = CalendarFormat.month.toString();

      await user.save();
    }

    onLoading() {
      refreshController.loadComplete();
    }

    return MultiValueListenableBuilder(
        valueListenables: valueListenables,
        builder: (btx, list, w) {
          return Column(
            children: [
              BannerAdWidget(),
              CommonAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: ContentView(selectedDateTime: selectedDateTime),
                ),
              ),
            ],
          );
        });
  }
}

class ContentView extends StatefulWidget {
  ContentView({super.key, required this.selectedDateTime});

  DateTime selectedDateTime;

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    UserBox? user = userRepository.user;
    String locale = context.locale.toString();
    int recordKey = dateTimeKey(widget.selectedDateTime);
    RecordBox? recordBox = recordRepository.recordBox.get(recordKey);
    CalendarFormat calendarFormat = calendarFormatInfo[user.calendarFormat]!;

    return Column(
      children: [
        TaskCalendar(locale: locale, calendarFormat: calendarFormat),
        MemoContainer(
          recordBox: recordBox,
          selectedDateTime: widget.selectedDateTime,
        ),
        TaskContainer(
          locale: locale,
          recordBox: recordBox,
          selectedDateTime: widget.selectedDateTime,
        ),
      ],
    );
  }
}
