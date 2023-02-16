import 'package:flutter/material.dart';
import 'package:ops_normal/utils/constants.dart';
import 'package:ops_normal/utils/constants_loader.dart';
import 'package:wiredash/wiredash.dart';
import 'route_map.dart';
import 'screens/main_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  static const appTitle = 'Ops Normal';

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<Constants> _constants =
      ConstantsLoader(constantsPath: "assets/constants.json").load();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Constants>(
        future: _constants,
        builder: (BuildContext context, AsyncSnapshot<Constants> snapshot) {
          String wiredashID = "";
          String wiredashSecret = "";
          if (snapshot.hasData) {
            wiredashID = snapshot.data!.wiredashID;
            wiredashSecret = snapshot.data!.wiredashSecret;
          }
          //else if (snapshot.hasError) {}
          //else {}
          return Wiredash(
              projectId: wiredashID,
              secret: wiredashSecret,
              child: MaterialApp(
                  title: App.appTitle,
                  routes: RouteMap.routes,
                  theme: ThemeData(
                      primarySwatch: Colors.green,
                      appBarTheme: const AppBarTheme(
                          color: Color.fromRGBO(0, 80, 47, 1)),
                      visualDensity: VisualDensity.adaptivePlatformDensity),
                  home: const MainScreen()));
        });
  }
}
