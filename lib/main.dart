import 'package:flutter/material.dart';
import 'package:project/page/homePage.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String initialRoute = 'home-page';

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomTabIndexProvider())
      ],
      child: MaterialApp(
        title: 'Todo Planner',
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: {
          'home-page': (context) => const HomePage(),
        },
      ),
    );
  }
}
