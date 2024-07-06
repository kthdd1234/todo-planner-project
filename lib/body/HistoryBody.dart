// ignore_for_file: prefer_is_empty
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/provider/HistoryOrderProvider.dart';
import 'package:project/provider/KeywordProvider.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/YearDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/ad/BannerAd.dart';
import 'package:project/widget/ad/NativeAd.dart';
import 'package:project/widget/history/HistoryImage.dart';
import 'package:project/widget/history/HistoryMemo.dart';
import 'package:project/widget/history/HistoryTask.dart';
import 'package:project/widget/history/HistoryTitle.dart';
import 'package:project/widget/history/historySearch.dart';
import 'package:provider/provider.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    List<RecordBox> recordList = recordRepository.recordList;
    bool isRecent = context.watch<HistoryOrderProvider>().isRecent;
    DateTime yearDateTime = context.watch<YearDateTimeProvider>().yearDateTime;

    recordList = isRecent ? recordList.reversed.toList() : recordList.toList();
    recordList = recordList
        .where((record) =>
            yFormatter(locale: locale, dateTime: record.createDateTime) ==
            yFormatter(locale: locale, dateTime: yearDateTime))
        .toList();

    bool isRecord = recordList.any((record) =>
        record.taskMarkList != null && record.taskMarkList?.length != 0);

    return Column(
      children: [
        const BannerAdWidget(),
        const CommonAppBar(),
        const HistorySearch(),
        Expanded(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: isRecord
                ? ContentView(recordList: recordList)
                : const EmptyHistory(),
          ),
        ),
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

  isShow(RecordBox record) {
    bool isVisibleMark = record.taskMarkList
            ?.any((taskMark) => isVisibleHistory(taskMark['mark'])) ==
        true;
    bool isVisibleMemo = record.memo != null && isVisibleHistory('memo');
    bool isVisibleImage = record.imageList != null && isVisibleHistory('image');

    return isVisibleMark || isVisibleMemo || isVisibleImage;
  }

  @override
  Widget build(BuildContext context) {
    List<RecordBox> recordList = widget.recordList;
    String keyword = context.watch<KeywordProvider>().keyword;
    bool isLight = context.watch<ThemeProvider>().isLight;

    if (keyword != '') {
      recordList = recordList.where((record) {
        if (record.createDateTime.year == 1000) {
          return true;
        }

        bool? isKeywordInTask = record.taskMarkList?.any((taskMark) {
              String taskId = taskMark['id'];
              String? taskName = taskRepository.taskBox.get(taskId)?.name;
              return taskName?.contains(keyword) == true;
            }) ==
            true;
        bool isKeywordInMemo = record.memo?.contains(keyword) == true;

        return isKeywordInTask || isKeywordInMemo;
      }).toList();
    }

    // if (isPremium == false && recordList.isNotEmpty) {
    //   for (var i = 0; i < recordList.length; i++) {
    //     log('$i ${i % 5 == 0}');
    //     if (i != 0 && i % 5 == 0) {
    //       recordList.insert(i, RecordBox(createDateTime: DateTime(1000)));
    //     }
    //   }
    // }

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, value, child) => recordList.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: recordList.map((record) {
                  if (record.createDateTime.year == 1000) {
                    return NativeAdWidget(isLight: isLight);
                  }

                  return isShow(record)
                      ? CommonContainer(
                          outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HistoryTitle(
                                isLight: isLight,
                                dateTime: record.createDateTime,
                              ),
                              HistoryTask(
                                isLight: isLight,
                                taskMarkList: record.taskMarkList,
                                taskOrderList: record.taskOrderList,
                              ),
                              HistoryMemo(isLight: isLight, memo: record.memo),
                              HistoryImage(uint8ListList: record.imageList)
                            ],
                          ),
                        )
                      : const CommonNull();
                }).toList(),
              ),
            )
          : const EmptyHistory(),
    );
  }
}

class EmptyHistory extends StatelessWidget {
  const EmptyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Center(
      child: CommonText(
        text: '히스토리 내역이 없어요',
        color: grey.original,
        isBold: !isLight,
      ),
    );
  }
}
