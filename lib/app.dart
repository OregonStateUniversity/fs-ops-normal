import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/new_estimate_screen.dart';
import 'screens/new_engagement_screen.dart';
import 'screens/estimate_screen.dart';
import 'screens/modify_estimate_screen.dart';
import 'screens/engagement_screen.dart';
import 'screens/about_screen.dart';
import 'screens/how_to_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatelessWidget {

  static final routes = {
    MainScreen.routeName: (context) => MainScreen(),
    SelectedEngagement.routeName: (BuildContext context) => SelectedEngagement(),
    CreateNewEngagement.routeName: (context) => CreateNewEngagement(),
    NewEstimateScreen.routeName: (context) => NewEstimateScreen(),
    EstimateScreen.routeName: (context) => EstimateScreen(),
    ModifyEstimateScreen.routeName: (context) => ModifyEstimateScreen(),
    AboutScreen.routeName: (context) => AboutScreen(),
    HowTo.routeName: (context) => HowTo(),
  };

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.autoScale(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(650, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        ]
      ),
      initialRoute: '/',
      title: 'Ops Normal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
    );
  }
}