import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';
import 'route_map.dart';
import 'screens/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});
  static const appTitle = 'Ops Normal';

  @override
  Widget build(BuildContext context) {
    return Wiredash(
        projectId: "ops-normal-zjn6peu",
        secret: "bNDp8F-lM4sZRHi-ibw4ub476QTHrQVg",
        child: MaterialApp(
            title: appTitle,
            routes: RouteMap.routes,
            theme: ThemeData(
                primarySwatch: Colors.green,
                appBarTheme:
                    const AppBarTheme(color: Color.fromRGBO(0, 80, 47, 1)),
                visualDensity: VisualDensity.adaptivePlatformDensity),
            home: const MainScreen()));
  }
}
