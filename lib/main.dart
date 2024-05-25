import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:project/page/ItemSettingPage.dart';
import 'package:project/page/groupCalendarPage.dart';
import 'package:project/page/groupItemListPage.dart';
import 'package:project/page/groupSettingPage.dart';
import 'package:project/page/groupTimelinePage.dart';
import 'package:project/page/homePage.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/provider/highlighterProvider.dart';
import 'package:project/provider/initGroupProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/repositories/init_hive.dart';
import 'package:project/util/constants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();
  await EasyLocalization.ensureInitialized();
  await InitHive().initializeHive();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ko'), Locale('en'), Locale('ja')],
      path: 'assets/translation',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomTabIndexProvider()),
        ChangeNotifierProvider(create: (context) => HighlighterProvider()),
        ChangeNotifierProvider(create: (context) => InitGroupProvider()),
        ChangeNotifierProvider(create: (context) => SelectedDateTimeProvider())
      ],
      child: MaterialApp(
        title: 'Todo Planner',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: initFontFamily,
          cupertinoOverrideTheme:
              const CupertinoThemeData(applyThemeToAll: true),
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: {
          'home-page': (context) => const HomePage(),
          'group-setting-page': (context) => const GroupSettingPage(),
          'group-item-list-page': (context) => const GroupItemListPage(),
          'group-calendar-page': (context) => const GroupCalendarPage(),
          'group-timeline-page': (context) => const GroupTimelinePage(),
        },
      ),
    );
  }
}
