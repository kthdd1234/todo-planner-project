import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:project/page/homePage.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/util/constants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();
  await EasyLocalization.ensureInitialized();

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
    ThemeData theme = ThemeData(fontFamily: initFontFamily);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomTabIndexProvider())
      ],
      child: MaterialApp(
        title: 'Todo Planner',
        theme: theme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: {
          'home-page': (context) => const HomePage(),
        },
      ),
    );
  }
}
