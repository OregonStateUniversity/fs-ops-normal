import 'dart:js';

import 'package:flutter/material.dart';

import 'screens/about_screen.dart';
import 'screens/create_order_screen.dart';
import 'screens/engagement_screen.dart';
import 'screens/estimate_screen.dart';
import 'screens/how_to_screen.dart';
import 'screens/incident_response_pocket_guide_screen.dart';
import 'screens/main_screen.dart';
import 'screens/modify_estimate_screen.dart';
import 'screens/new_engagement_screen.dart';
import 'screens/red_book_screen.dart';

class App extends StatelessWidget {
  static final routes = {
    MainScreen.routeName: (context) => MainScreen(),
    AboutScreen.routeName: (context) => AboutScreen(),
    CreateNewEngagement.routeName: (context) => CreateNewEngagement(),
    CreateOrderScreen.routeName: (context) => CreateOrderScreen(),
    EstimateScreen.routeName: (context) => EstimateScreen(),
    HowToScreen.routeName: (context) => HowToScreen(),
    IncidentResponsePocketGuideScreen.routeName: (context) =>
        IncidentResponsePocketGuideScreen(),
    ModifyEstimateScreen.routeName: (context) => ModifyEstimateScreen(),
    SelectedEngagement.routeName: (context) => SelectedEngagement(),
    RedBookScreen.routeName: (context) => RedBookScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MainScreen.routeName,
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
