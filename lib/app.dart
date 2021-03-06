import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/new_estimate_screen.dart';
import 'screens/new_engagement_screen.dart';
import 'screens/estimate_screen.dart';
import 'screens/modify_estimate_screen.dart';
import 'screens/engagement_screen.dart';
import 'screens/about_screen.dart';

class App extends StatelessWidget {

  static final routes = {
    MainScreen.routeName: (context) => MainScreen(),
    SelectedEngagement.routeName: (BuildContext context) => SelectedEngagement(),
    CreateNewEngagement.routeName: (context) => CreateNewEngagement(),
    NewEstimateScreen.routeName: (context) => NewEstimateScreen(),
    EstimateScreen.routeName: (context) => EstimateScreen(),
    ModifyEstimateScreen.routeName: (context) => ModifyEstimateScreen(),
    AboutScreen.routeName: (context) => AboutScreen(),
  };

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
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
