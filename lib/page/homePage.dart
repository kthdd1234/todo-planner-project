// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:project/body/CalendarBody.dart';
import 'package:project/body/HistoryBody.dart';
import 'package:project/body/SettingBody.dart';
import 'package:project/body/TaskBody.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/util/service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late AppLifecycleReactor _appLifecycleReactor;

  // initializeAppOpenAd() {
  //   AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
  //   _appLifecycleReactor = AppLifecycleReactor(
  //     appOpenAdManager: appOpenAdManager,
  //   );
  //   _appLifecycleReactor.listenToAppStateChanges();
  // }

  initializePremium() async {
    bool isPremium = await isPurchasePremium();
    context.read<PremiumProvider>().setPremiumValue(isPremium);
  }

  initializeHiveDB() async {
    UserBox? user = userRepository.user;

    if (mounted) {
      user.theme ??= 'light';
      user.filterIdList ??= filterIdList;

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<ThemeProvider>().setThemeValue(user.theme!);
      });
    }

    await user.save();
  }

  @override
  void initState() {
    // initializeAppOpenAd();
    initializePremium();
    initializeHiveDB();

    super.initState();
  }

  onBottomNavigation(int newIndex) {
    context.read<BottomTabIndexProvider>().changeSeletedIdx(newIndex: newIndex);
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    int seletedIdx = context.watch<BottomTabIndexProvider>().seletedIdx;
    List<BottomNavigationBarItem> items = bottomNavigationBarItemList
        .map((item) => BottomNavigationBarItem(
              icon: item.icon,
              label: item.label,
            ))
        .toList();

    final bodyList = [
      const TaskBody(),
      const CalendarBody(),
      const HistoryBody(),
      const SettingBody()
    ];

    return CommonBackground(
      child: CommonScaffold(
        body: bodyList[seletedIdx],
        isFab: seletedIdx == 0,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: items,
            elevation: 0,
            selectedItemColor: isLight ? indigo.s300 : Colors.white,
            selectedLabelStyle: TextStyle(
              color: isLight ? indigo.s200 : Colors.white,
              fontWeight: isLight ? null : FontWeight.bold,
            ),
            unselectedItemColor: // const Color(0xffA2A7B2)
                isLight
                    ? const Color.fromARGB(255, 115, 120, 139)
                    : const Color(0xff616261),
            unselectedLabelStyle:
                TextStyle(fontWeight: isLight ? null : FontWeight.bold),
            currentIndex: seletedIdx,
            onTap: onBottomNavigation,
          ),
        ),
      ),
    );
  }
}

// late AppLifecycleReactor _appLifecycleReactor;

  // initializeAppOpenAd() {
  //   AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
  //   _appLifecycleReactor = AppLifecycleReactor(
  //     appOpenAdManager: appOpenAdManager,
  //   );
  //   _appLifecycleReactor.listenToAppStateChanges();
  // }
    // initializeAppOpenAd();
