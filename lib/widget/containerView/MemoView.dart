import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonImage.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/main.dart';
import 'package:project/page/MemoSettingPage.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:project/widget/memo/MemoBackground.dart';
import 'package:project/widget/modalSheet/MemoModalSheet.dart';
import 'package:provider/provider.dart';

class MemoView extends StatefulWidget {
  MemoView({super.key});

  @override
  State<MemoView> createState() => _MemoViewState();
}

class _MemoViewState extends State<MemoView> {
  List<MemoInfoClass> memoInfoList = [];
  MemoInfoClass? memoInfo;
  Uint8List? uint8List;

  getMemoInfo(DateTime selectedDateTime, List<MemoInfoClass> list) {
    int index = list.indexWhere(
      (memoInfo) => memoInfo.dateTimeKey == dateTimeKey(selectedDateTime),
    );

    memoInfo = index != -1 ? list[index] : null;

    if (memoInfo?.imgUrl != null) {
      getImg(memoInfo!.imgUrl!).then(
          (uint8ListResult) => setState(() => uint8List = uint8ListResult));
    }
  }

  memoSnapshotsListener() {
    List<MemoInfoClass> newMemoInfoList = [];

    memoMethod.memoSnapshots.listen(
      (event) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            for (final doc in event.docs) {
              MemoInfoClass memoInfo = MemoInfoClass.fromJson(
                doc.data() as Map<String, dynamic>,
              );

              newMemoInfoList.add(memoInfo);
            }
          },
        );
      },
    ).onError((err) => log('$err'));

    setState(() => memoInfoList = newMemoInfoList);
    return newMemoInfoList;
  }

  @override
  void initState() {
    super.initState();

    List<MemoInfoClass> newMemoInfoList = memoSnapshotsListener();
    getMemoInfo(DateTime.now(), newMemoInfoList);
  }

  @override
  void didChangeDependencies() {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    getMemoInfo(selectedDateTime, memoInfoList);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    bool isLight = context.watch<ThemeProvider>().isLight;

    Color containerColor = isLight ? memoBgColor : darkContainerColor;
    Color borderColor = isLight ? orange.s50 : Colors.white10;

    onMemo() {
      showModalBottomSheet(
        context: context,
        builder: (context) => MemoModalSheet(
          selectedDateTime: selectedDateTime,
          onEdit: () {
            navigatorPop(context);
            movePage(
              context: context,
              page: MemoSettingPage(
                initDateTime: selectedDateTime,
                memoInfo: memoInfo,
              ),
            );
          },
          onRemove: () async {
            String mid = dateTimeKey(selectedDateTime).toString();

            if (memoInfo?.imgUrl != null) {
              await storageRef.child(memoInfo!.imgUrl!).delete();
            }

            await memoMethod.removeMemo(mid: mid);

            setState(() {
              memoInfoList.removeWhere(
                (memoInfo) =>
                    memoInfo.dateTimeKey == dateTimeKey(selectedDateTime),
              );
              memoInfo = null;
              uint8List = null;
            });

            navigatorPop(context);
          },
        ),
      );
    }

    return memoInfo != null
        ? CommonContainer(
            onTap: onMemo,
            radius: 0,
            color: containerColor,
            innerPadding: const EdgeInsets.all(0),
            outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HorizentalBorder(colorName: '주황색'),
                CustomPaint(
                  painter: MemoBackground(isLight: isLight, color: orange.s50),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12.5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        memoInfo?.imgUrl != null
                            ? MemoImg(uint8List: uint8List, onTap: onMemo)
                            : const CommonNull(),
                        memoInfo?.imgUrl != null && memoInfo?.text != null
                            ? CommonSpace(height: 10)
                            : const CommonNull(),
                        memoInfo?.text != null
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CommonText(
                                  text: memoInfo!.text!,
                                  textAlign: TextAlign.start,
                                  isBold: !isLight,
                                  isNotTr: true,
                                ),
                              )
                            : const CommonNull()
                      ],
                    ),
                  ),
                ),
                HorizentalBorder(colorName: '주황색'),
              ],
            ),
          )
        : const CommonNull();
  }
}

class MemoImg extends StatelessWidget {
  MemoImg({super.key, this.uint8List, required this.onTap});

  Uint8List? uint8List;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    if (uint8List == null) {
      return SizedBox(
        height: 300,
        child: Center(
          child: CommonText(
            text: '이미지 로드 중...',
            fontSize: 12,
            color: grey.original,
          ),
        ),
      );
    }

    return CommonImage(
      uint8List: uint8List!,
      height: 300,
      onTap: (_) => onTap(),
    );
  }
}
