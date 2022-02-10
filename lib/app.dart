import 'package:flutter/material.dart';
import 'package:hose_jockey/screens/handbookpdf_screen.dart';
import 'screens/main_screen.dart';
import 'screens/new_estimate_screen.dart';
import 'screens/new_engagement_screen.dart';
import 'screens/estimate_screen.dart';
import 'screens/modify_estimate_screen.dart';
import 'screens/engagement_screen.dart';
import 'screens/about_screen.dart';
import 'screens/how_to_screen.dart';
import 'screens/create_order_screen.dart';

class App extends StatelessWidget {
  static final routes = {
    MainScreen.routeName: (context) => MainScreen(),
    SelectedEngagement.routeName: (BuildContext context) =>
        SelectedEngagement(),
    CreateNewEngagement.routeName: (context) => CreateNewEngagement(),
    NewEstimateScreen.routeName: (context) => NewEstimateScreen(),
    EstimateScreen.routeName: (context) => EstimateScreen(),
    ModifyEstimateScreen.routeName: (context) => ModifyEstimateScreen(),
    AboutScreen.routeName: (context) => AboutScreen(),
    HowTo.routeName: (context) => HowTo(),
    // Apparently flutter thinks this key is equal to another. Its simply not.
    '/createOrderScreen': (context) => CreateOrderScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
