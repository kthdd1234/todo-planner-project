import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/main.dart';
import 'package:project/page/MemoSettingPage.dart';
import 'package:project/page/HomePage.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:project/widget/memo/MemoBackground.dart';
import 'package:project/widget/memo/MemoImage.dart';
import 'package:project/widget/modalSheet/MemoModalSheet.dart';
import 'package:provider/provider.dart';

class MemoView extends StatefulWidget {
  MemoView({super.key, required this.memoInfoList});

  List<MemoInfoClass> memoInfoList;

  @override
  State<MemoView> createState() => _MemoViewState();
}

class _MemoViewState extends State<MemoView> {
  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    Color containerColor = isLight ? memoBgColor : darkContainerColor;
    Color borderColor = isLight ? orange.s50 : Colors.white10;

    int index = widget.memoInfoList.indexWhere(
      (memoInfo) => memoInfo.dateTimeKey == dateTimeKey(selectedDateTime),
    );
    MemoInfoClass? memoInfo = index != -1 ? widget.memoInfoList[index] : null;

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
                memoInfoList: widget.memoInfoList,
                memoInfo: memoInfo,
              ),
            );
          },
          onRemove: () async {
            String mid = dateTimeKey(selectedDateTime).toString();

            if (memoInfo?.imgUrl != null && memoInfo?.path != null) {
              await DefaultCacheManager().removeFile(memoInfo!.imgUrl!);
              await storageRef.child(memoInfo!.path!).delete();
            }

            await memoMethod.removeMemo(mid: mid);

            setState(() {
              widget.memoInfoList.removeWhere(
                (memoInfo) =>
                    memoInfo.dateTimeKey == dateTimeKey(selectedDateTime),
              );
              memoInfo = null;
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
                            ? MemoImage(
                                imageUrl: memoInfo?.imgUrl,
                                onTap: onMemo,
                              )
                            : const CommonNull(),
                        memoInfo?.imgUrl != null && memoInfo?.text != null
                            ? CommonSpace(height: 10)
                            : const CommonNull(),
                        memoInfo?.text != null
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CommonText(
                                  text: memoInfo!.text!,
                                  textAlign:
                                      memoInfo?.textAlign ?? TextAlign.left,
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
