// ignore_for_file: prefer_is_empty
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/ad/NativeAd.dart';
import 'package:project/widget/history/HistoryImage.dart';
import 'package:project/widget/history/HistoryMemo.dart';
import 'package:project/widget/history/HistoryTask.dart';
import 'package:project/widget/history/HistoryTitle.dart';
import 'package:project/widget/popup/MonthPopup.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime yearDateTime = DateTime.now();
  bool isRecent = true;

  onYear() {
    showDialog(
      context: context,
      builder: (context) => CalendarPopup(
        view: DateRangePickerView.decade,
        initialdDateTime: yearDateTime,
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) async {
          setState(() => yearDateTime = args.value);
          navigatorPop(context);
        },
      ),
    );
  }

  onOrder() {
    setState(() => isRecent = !isRecent);
  }

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
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    String locale = context.locale.toString();
    List<RecordBox> recordList = isRecent
        ? recordRepository.recordList.reversed.toList()
        : recordRepository.recordList.toList();
    bool isRecord = recordList.any((record) =>
        record.taskMarkList != null && record.taskMarkList?.length != 0);

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

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          isCenter: false,
          title: '히스토리',
          actions: [
            wAction(
              right: 5,
              text: yFormatter(locale: locale, dateTime: yearDateTime),
              bgColor: indigo.s300,
              onTap: onYear,
            ),
            wAction(
              right: 15,
              text: isRecent ? '최신순' : '과거순',
              bgColor: isRecent ? blue.s300 : red.s300,
              onTap: onOrder,
            ),
          ],
        ),
        body: isRecord
            ? ListView(
                children: recordList.map((record) {
                  if (record.createDateTime.year == 1000) {
                    return NativeAdWidget();
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
              )
            : Center(
                child: CommonText(
                text: '히스토리 내역이 없어요.',
                color: grey.original,
              )),
      ),
    );
  }
}
