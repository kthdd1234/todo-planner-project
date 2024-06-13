// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/container/MemoContainer.dart';
import 'package:project/widget/container/TaskContainer.dart';
import 'package:provider/provider.dart';

class TaskBody extends StatelessWidget {
  const TaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return MultiValueListenableBuilder(
        valueListenables: valueListenables,
        builder: (btx, list, w) {
          return ListView(
            children: [
              CommonAppBar(),
              ContentView(selectedDateTime: selectedDateTime)
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
  onHorizontalDragEnd(DragEndDetails details, DateTime selectedDateTime) {
    if (details.primaryVelocity == null) {
      return;
    } else if (details.primaryVelocity! > 0) {
      selectedDateTime = selectedDateTime.subtract(Duration(days: 1));
    } else if (details.primaryVelocity! < 0) {
      selectedDateTime = selectedDateTime.add(Duration(days: 1));
    }

    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: selectedDateTime);
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    RecordBox? recordBox =
        recordRepository.recordBox.get(dateTimeKey(widget.selectedDateTime));

    return GestureDetector(
      onHorizontalDragEnd: (details) => onHorizontalDragEnd(
        details,
        widget.selectedDateTime,
      ),
      child: Column(
        children: [
          TaskContainer(
            locale: locale,
            recordBox: recordBox,
            selectedDateTime: widget.selectedDateTime,
          ),
          MemoContainer(
            recordBox: recordBox,
            selectedDateTime: widget.selectedDateTime,
          ),
        ],
      ),
    );
  }
}


// return CarouselSlider.builder(
//   itemCount: 2,
//   options: CarouselOptions(
//     aspectRatio: 0.65,
//     viewportFraction: 1,
//     enableInfiniteScroll: false,
//     onPageChanged: onPageChanged,
//   ),
//   itemBuilder: (ctx, itemIdx, pvIdx) =>
//   Column(
//     children: [
//       MemoContainer(recordBox: recordBox),
//       TaskContainer(
//         recordBox: recordBox,
//         selectedDateTime: selectedDateTime,
//       )
//     ],
//   ),
// );
