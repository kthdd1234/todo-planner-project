// ignore_for_file: prefer_is_empty
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/provider/HistoryOrderProvider.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/YearDateTimeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/ad/NativeAd.dart';
import 'package:project/widget/history/HistoryImage.dart';
import 'package:project/widget/history/HistoryMemo.dart';
import 'package:project/widget/history/HistoryTask.dart';
import 'package:project/widget/history/HistoryTitle.dart';
import 'package:provider/provider.dart';

class HistoryBody extends StatefulWidget {
  const HistoryBody({super.key});

  @override
  State<HistoryBody> createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<YearDateTimeProvider>()
          .changeYearDateTime(dateTime: DateTime.now());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<RecordBox> recordList = recordRepository.recordList;
    bool isRecent = context.watch<HistoryOrderProvider>().isRecent;
    DateTime yearDateTime = context.watch<YearDateTimeProvider>().yearDateTime;
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    String locale = context.locale.toString();

    recordList = isRecent ? recordList.reversed.toList() : recordList.toList();
    recordList = recordList
        .where((record) =>
            yFormatter(locale: locale, dateTime: record.createDateTime) ==
            yFormatter(locale: locale, dateTime: yearDateTime))
        .toList();

    if (isPremium == false && recordList.isNotEmpty) {
      for (var i = 0; i < recordList.length; i++) {
        if (i != 0 && i % 4 == 0) {
          recordList.insert(i, RecordBox(createDateTime: DateTime(1000)));
        }
      }
    }

    bool isRecord = recordList.any((record) =>
        record.taskMarkList != null && record.taskMarkList?.length != 0);

    return isRecord
        ? SingleChildScrollView(
            child: Column(
              children: [
                const CommonAppBar(),
                ContentView(recordList: recordList)
              ],
            ),
          )
        : Column(
            children: [
              const CommonAppBar(),
              Expanded(
                child: Center(
                  child: CommonText(text: '히스토리 내역이 없어요', color: grey.original),
                ),
              )
            ],
          );
  }
}

class ContentView extends StatefulWidget {
  ContentView({super.key, required this.recordList});

  List<RecordBox> recordList;

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  wAction({
    required double right,
    required String text,
    required Color bgColor,
    required Function() onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: right),
      child: CommonTag(
        text: text,
        fontSize: 11,
        isBold: true,
        textColor: Colors.white,
        bgColor: bgColor,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.recordList.map((record) {
        if (record.createDateTime.year == 1000) {
          return const NativeAdWidget();
        }

        bool isShow = (record.taskMarkList != null &&
                record.taskMarkList?.isNotEmpty == true) ||
            record.memo != null ||
            record.imageList != null;

        return isShow
            ? CommonContainer(
                outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HistoryTitle(dateTime: record.createDateTime),
                    HistoryTask(
                      taskMarkList: record.taskMarkList,
                      taskOrderList: record.taskOrderList,
                    ),
                    HistoryMemo(memo: record.memo),
                    HistoryImage(uint8ListList: record.imageList)
                  ],
                ),
              )
            : const CommonNull();
      }).toList(),
    );
  }
}

// CommonBackground(
//       child: CommonScaffold(
//         appBarInfo: AppBarInfoClass(
//           isCenter: false,
//           title: '히스토리',
//           actions: [
//             wAction(
//               right: 5,
//               text: yFormatter(locale: locale, dateTime: yearDateTime),
//               bgColor: indigo.s300,
//               onTap: onYear,
//             ),
//             wAction(
//               right: 15,
//               text: isRecent ? '최신순' : '과거순',
//               bgColor: isRecent ? blue.s300 : red.s300,
//               onTap: onOrder,
//             ),
//           ],
//         ),
//         body: ),
//     );
     