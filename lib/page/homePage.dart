// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:project/body/CalendarBody.dart';
import 'package:project/body/SettingBody.dart';
import 'package:project/body/TaskBody.dart';
import 'package:project/body/TrackerBody.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/method/GroupMethod.dart';
import 'package:project/method/MemoMethod.dart';
import 'package:project/method/UserMethod.dart';
import 'package:project/provider/GroupInfoListProvider.dart';
import 'package:project/provider/MemoInfoListProvider.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/UserInfoProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';

UserMethod userMethod = UserMethod();
GroupMethod groupMethod = GroupMethod();
MemoMethod memoMethod = MemoMethod();

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.locale});

  String locale;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late AppLifecycleReactor _appLifecycleReactor;

  // initialzeAppOpening() {
  //   AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
  //   _appLifecycleReactor = AppLifecycleReactor(
  //     appOpenAdManager: appOpenAdManager,
  //   );
  //   _appLifecycleReactor.listenToAppStateChanges();
  // }

  initializePremium() async {
    bool isPremium = await isPurchasePremium();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PremiumProvider>().setPremiumValue(isPremium);
      }
    });
  }

  initializeUserInfo() {
    userMethod.userSnapshots.listen(
      (event) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            Map<String, dynamic>? json = event.data();

            if (json != null) {
              UserInfoClass userInfo = UserInfoClass.fromJson(json);

              if (mounted) {
                context.read<ThemeProvider>().setThemeValue(userInfo.theme);
                context
                    .read<UserInfoProvider>()
                    .changeUserInfo(newuUserInfo: userInfo);

                int seletedIdx =
                    Provider.of<BottomTabIndexProvider>(context, listen: false)
                        .seletedIdx;

                if (seletedIdx != 3) {
                  context
                      .read<BottomTabIndexProvider>()
                      .changeSeletedIdx(newIndex: userInfo.appStartIndex);
                }
              }
            }
          },
        );
      },
    ).onError((err) => log('$err'));
  }

  initializeGroupInfoList() {
    groupMethod.groupSnapshots.listen((event) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          List<GroupInfoClass> groupInfoList = [];

          for (final doc in event.docs) {
            GroupInfoClass groupInfo = GroupInfoClass.fromJson(
              doc.data() as Map<String, dynamic>,
            );

            groupInfoList.add(groupInfo);
          }
          if (mounted) {
            context
                .read<GroupInfoListProvider>()
                .changeGroupInfoList(newGroupInfoList: groupInfoList);
          }
        },
      );
    }).onError((err) => log('$err'));
  }

  initializeMemoInfoList() {
    memoMethod.memoSnapshots.listen(
      (event) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            List<MemoInfoClass> memoInfoList = [];

            for (final doc in event.docs) {
              MemoInfoClass memoInfo = MemoInfoClass.fromJson(
                doc.data() as Map<String, dynamic>,
              );

              memoInfoList.add(memoInfo);
            }
            if (mounted) {
              context
                  .read<MemoInfoListProvider>()
                  .changeMemoInfoList(newMemoInfoList: memoInfoList);
            }
          },
        );
      },
    ).onError((err) => log('$err'));
  }

  initializeInAppReview() async {
    int day = DateTime.now().day;
    InAppReview inAppReview = InAppReview.instance;
    bool isAvailable = await inAppReview.isAvailable();
    bool isDateTime = day == 7 || day == 14 || day == 28;

    if (isAvailable && isDateTime) {
      inAppReview.requestReview();
    }
  }

  @override
  void initState() {
    // initialzeAppOpening();
    initializePremium();
    initializeUserInfo();
    initializeGroupInfoList();
    initializeMemoInfoList();
    initializeInAppReview();

    super.initState();
  }

  onBottomNavigation(int newIndex) {
    if (newIndex == 0 || newIndex == 1) {
      context
          .read<SelectedDateTimeProvider>()
          .changeSelectedDateTime(dateTime: DateTime.now());
      context
          .read<TitleDateTimeProvider>()
          .changeTitleDateTime(dateTime: DateTime.now());
    }

    context.read<BottomTabIndexProvider>().changeSeletedIdx(newIndex: newIndex);
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    int seletedIdx = context.watch<BottomTabIndexProvider>().seletedIdx;

    Widget body = [
      const TaskBody(),
      const CalendarBody(),
      const TrackerBody(),
      const SettingBody()
    ][seletedIdx];

    return CommonBackground(
      child: CommonScaffold(
        body: body,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: BottomNavigationBar(
            items: getBnbiList(isLight, seletedIdx),
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: seletedIdx,
            onTap: onBottomNavigation,
          ),
        ),
      ),
    );
  }
}
