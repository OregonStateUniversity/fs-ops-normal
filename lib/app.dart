import 'package:flutter/material.dart';
import 'route_map.dart';
import '/screens/main_screen.dart';

class App extends StatelessWidget {
  static const APP_TITLE = 'Ops Normal';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: APP_TITLE,
        routes: RouteMap.routes,
        theme: ThemeData(
            primarySwatch: Colors.green,
            appBarTheme:
                const AppBarTheme(color: const Color.fromRGBO(0, 80, 47, 1)),
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: MainScreen());
  }
}
