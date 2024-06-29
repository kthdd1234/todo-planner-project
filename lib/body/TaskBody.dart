// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
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

    return GestureDetector(
      onHorizontalDragEnd: onHorizontalDragEnd,
      child: MultiValueListenableBuilder(
          valueListenables: valueListenables,
          builder: (btx, list, w) {
            return SmartRefresher(
              header: ClassicHeader(
                height: 0,
                spacing: 0,
                refreshingText: '',
                completeText: '',
                idleText: '',
                releaseText: null,
                releaseIcon: null,
                completeIcon: null,
              ),
              footer: ClassicFooter(
                spacing: 0,
                height: 0,
                loadingText: '',
                canLoadingText: '',
                idleText: '',
              ),
              onLoading: onLoading,
              onRefresh: onRefresh,
              controller: refreshController,
              child: ListView(
                children: [
                  CommonAppBar(),
                  ContentView(selectedDateTime: selectedDateTime)
                ],
              ),
            );
          }),
    );
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
    String locale = context.locale.toString();
    RecordBox? recordBox =
        recordRepository.recordBox.get(dateTimeKey(widget.selectedDateTime));

    return Column(
      children: [
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
