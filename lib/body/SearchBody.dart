// ignore_for_file: prefer_is_empty
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/provider/HistoryOrderProvider.dart';
import 'package:project/provider/KeywordProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/ad/BannerAd.dart';
import 'package:project/widget/appBar/SearchAppBar.dart';
import 'package:project/widget/search/SearchImage.dart';
import 'package:project/widget/search/SearchMemo.dart';
import 'package:project/widget/search/SearchTask.dart';
import 'package:project/widget/search/SearchTitle.dart';
import 'package:project/widget/search/SearchBar.dart';
import 'package:provider/provider.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BannerAdWidget(),
        SearchAppBar(),
        const SearchItemBar(),
        Expanded(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ContentView(),
          ),
        ),
      ],
    );
  }
}

class ContentView extends StatefulWidget {
  const ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  // wAction({
  //   required double right,
  //   required String text,
  //   required Color bgColor,
  //   required Function() onTap,
  // }) {
  //   return Padding(
  //     padding: EdgeInsets.only(right: right),
  //     child: CommonTag(
  //       text: text,
  //       fontSize: 11,
  //       isBold: true,
  //       textColor: Colors.white,
  //       bgColor: bgColor,
  //       onTap: onTap,
  //     ),
  //   );
  // }

  // isShow(RecordBox record) {
  //   bool isVisibleMark = record.taskMarkList
  //           ?.any((taskMark) => isSearchCategory(taskMark['mark'])) ==
  //       true;
  //   bool isVisibleMemo = record.memo != null && isSearchCategory('memo');
  //   bool isVisibleImage = record.imageList != null && isSearchCategory('image');

  //   return isVisibleMark || isVisibleMemo || isVisibleImage;
  // }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isRecent = context.watch<HistoryOrderProvider>().isRecent;
    String keyword = context.watch<KeywordProvider>().keyword;

    // if (keyword != '') {
    //   recordList = recordList.where((record) {
    //     if (record.createDateTime.year == 1000) {
    //       return true;
    //     }

    //     bool? isKeywordInTask = record.taskMarkList?.any((taskMark) {
    //           String taskId = taskMark['id'];
    //           String? taskName = taskRepository.taskBox.get(taskId)?.name;
    //           return taskName?.contains(keyword) == true;
    //         }) ==
    //         true;
    //     bool isKeywordInMemo = record.memo?.contains(keyword) == true;

    //     return isKeywordInTask || isKeywordInMemo;
    //   }).toList();
    // }

    return MultiValueListenableBuilder(
        valueListenables: valueListenables,
        builder: (context, value, child) {
          List<TaskBox> taskList = taskRepository.taskList;
          List<RecordBox> recordList = recordRepository.recordList;
          List<TaskBox> searchTaskList = taskRepository.taskList
              .where((task) => task.name.contains(keyword))
              .toList();
          List<RecordBox> searchRecordList = recordRepository.recordList
              .where((record) => record.memo?.contains(keyword) == true)
              .toList();

          return recordList.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: recordList.map(
                      (record) {
                        return CommonContainer(
                          outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SearchTitle(
                                isLight: isLight,
                                dateTime: record.createDateTime,
                              ),
                              SearchTask(
                                isLight: isLight,
                                taskMarkList: record.taskMarkList,
                                taskOrderList: record.taskOrderList,
                              ),
                              SearchMemo(
                                isLight: isLight,
                                memo: record.memo,
                              ),
                              SearchImage(uint8ListList: record.imageList)
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                )
              : const EmptyResult();
        });
  }
}

class EmptyResult extends StatelessWidget {
  const EmptyResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 7.5,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: indigo.s200,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: CommonText(
                  text: '+ 검색어 만들기',
                  fontSize: 13,
                  color: Colors.white,
                  isBold: true,
                ),
              ),
            ],
          ),
        ),
        // const Spacer(),
        // CommonText(
        //   text: '이전의 할 일 또는 메모를\n검색해보세요',
        //   color: grey.original,
        //   isBold: !isLight,
        // ),
        // const Spacer(),
      ],
    );
  }
}
