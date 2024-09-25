import 'dart:developer';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:project/method/GroupMethod.dart';
import 'package:project/method/TaskMethod.dart';
import 'package:project/method/UserMethod.dart';
import 'package:project/page/HomePage.dart';
import 'package:project/page/IntroPage.dart';
import 'package:project/provider/HistoryOrderProvider.dart';
import 'package:project/provider/KeywordProvider.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/ReloadProvider.dart';
import 'package:project/provider/YearDateTimeProvider.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/repositories/init_hive.dart';
import 'package:project/util/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'firebase_options.dart';

PurchasesConfiguration _configuration =
    PurchasesConfiguration(Platform.isIOS ? appleApiKey : googleApiKey);
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

UserMethod userMethod = UserMethod();
GroupMethod groupMethod = GroupMethod();
TaskMethod taskMethod = TaskMethod();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Purchases.configure(_configuration);
  await MobileAds.instance.initialize();
  await initializeDateFormatting();
  await EasyLocalization.ensureInitialized();
  await InitHive().initializeHive();
  await HomeWidget.setAppGroupId('group.todo-planner-widget');
  await dotenv.load(fileName: ".env");
  KakaoSdk.init(
    nativeAppKey: '958cf1ab1b9ab22445351f1b6181c38f',
    javaScriptAppKey: '6c33a55f2e1fc0d920781f3dc1b4a8a4',
  );

  log('안드로이드 카카오 로그인 구현 시 릴리즈 키 해시 등록 필요!!');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomTabIndexProvider()),
        ChangeNotifierProvider(create: (context) => SelectedDateTimeProvider()),
        ChangeNotifierProvider(create: (context) => TitleDateTimeProvider()),
        ChangeNotifierProvider(create: (context) => PremiumProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => YearDateTimeProvider()),
        ChangeNotifierProvider(create: (context) => HistoryOrderProvider()),
        ChangeNotifierProvider(create: (context) => KeywordProvider()),
        ChangeNotifierProvider(create: (context) => ReloadProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('ko'), Locale('en'), Locale('ja')],
        path: 'assets/translation',
        fallbackLocale: const Locale('en'),
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
  // Box<UserBox>? userBox;
  bool isLogin = false;

  onLogin() {
    auth.authStateChanges().listen((user) {
      if (user != null && mounted) setState(() => isLogin = true);
      // log('${auth.currentUser}');
    });
  }

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

  initializeBottomNavition() {
    // UserBox? user = userBox?.get('userProfile');

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   context
    //       .read<BottomTabIndexProvider>()
    //       .changeSeletedIdx(newIndex: user?.appStartIndex ?? 0);
    // });
  }

  @override
  void initState() {
    // userBox = Hive.box('userBox');

    initializeBottomNavition();
    appTrackingTransparency();
    onLogin();

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // UserBox? user = userBox?.get('userProfile');
    // String locale = context.locale.toString();
    // bool isBackground = state == AppLifecycleState.paused ||
    //     state == AppLifecycleState.detached;

    // if (isBackground && user != null) {
    //   await HomeWidgetService().updateTodoRoutin(locale);
    // }
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
    String locale = context.locale.toString();
    context.watch<ReloadProvider>().isReload;

    log('isLogin => $isLogin');

    return MaterialApp(
      title: 'Todo Tracker',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: initFontFamily,
        cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: isLogin ? HomePage(locale: locale) : const IntroPage(),
      // routes: {
      //   'home-page': (context) => HomePage(locale: locale),
      //   'intro-page': (context) => const IntroPage()
      // },
    );
  }
}


    // bool isUser = UserRepository().isUser;
    // UserBox? user = userBox?.get('userProfile');
    // String? fontFamily = user?.fontFamily ?? initFontFamily;