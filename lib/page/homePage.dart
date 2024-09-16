// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/body/CalendarBody.dart';
import 'package:project/body/SettingBody.dart';
import 'package:project/body/TaskBody.dart';
import 'package:project/body/TrackerBody.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/KeywordProvider.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/util/service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.locale});

  String locale;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppLifecycleReactor _appLifecycleReactor;

  initializePremium() async {
    bool isPremium = await isPurchasePremium();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PremiumProvider>().setPremiumValue(isPremium);
    });
  }

  initializeHiveDB() async {
    UserBox? user = userRepository.user;

    if (mounted) {
      user.theme ??= 'light';
      user.widgetTheme ??= 'light';
      user.filterIdList ??= filterIdList;
      user.background ??= '0';
      user.appStartIndex ??= 0;

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<ThemeProvider>().setThemeValue(user.theme!);
      });
    }

    await user.save();
  }

  @override
  void initState() {
    initializePremium();
    initializeHiveDB();

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
    } else if (newIndex == 2) {
      context.read<KeywordProvider>().changeKeyword('');
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
        // isFab: seletedIdx == 0 || seletedIdx == 1,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
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
