import 'dart:developer';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/page/HomePage.dart';
import 'package:project/page/IntroPage.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/repositories/init_hive.dart';
import 'package:project/repositories/user_repository.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/service.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

PurchasesConfiguration _configuration =
    PurchasesConfiguration(Platform.isIOS ? appleApiKey : googleApiKey);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Purchases.configure(_configuration);
  await MobileAds.instance.initialize();
  await initializeDateFormatting();
  await EasyLocalization.ensureInitialized();
  await InitHive().initializeHive();
  await HomeWidget.setAppGroupId('group.todo-planner-widget');
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomTabIndexProvider()),
        ChangeNotifierProvider(create: (context) => SelectedDateTimeProvider()),
        ChangeNotifierProvider(create: (context) => TitleDateTimeProvider()),
        ChangeNotifierProvider(create: (context) => PremiumProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('ko'), Locale('en'), Locale('ja')],
        path: 'assets/translation',
        fallbackLocale: const Locale('ko'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Box<UserBox>? userBox;

  appTrackingTransparency() async {
    try {
      TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;

      if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    } on PlatformException {
      log('error');
    }
  }

  launchedFromHomeWidget(Uri? uri) async {
    DateTime now = DateTime.now();

    if (uri != null) {
      context
          .read<SelectedDateTimeProvider>()
          .changeSelectedDateTime(dateTime: now);
      context.read<TitleDateTimeProvider>().changeTitleDateTime(dateTime: now);
    }
  }

  @override
  void initState() {
    userBox = Hive.box('userBox');
    appTrackingTransparency();

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    UserBox? user = userBox?.get('userProfile');
    bool isBackground = state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached;

    if (isBackground && user != null) {
      await HomeWidgetService().updateTodoRoutin();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    HomeWidget.initiallyLaunchedFromHomeWidget().then(launchedFromHomeWidget);
    HomeWidget.widgetClicked.listen(launchedFromHomeWidget);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isUser = UserRepository().isUser;
    String initialRoute = isUser ? 'home-page' : 'intro-page';

    return MaterialApp(
      title: 'Todo Planner',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: initFontFamily,
        cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        'home-page': (context) => const HomePage(),
        'intro-page': (context) => const IntroPage()
      },
    );
  }
}
