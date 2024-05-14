import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:project/page/homePage.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/util/constants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(const MyApp());
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
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: {
          'home-page': (context) => const HomePage(),
        },
      ),
    );
  }
}
