import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/new_estimate_screen.dart';
import 'screens/new_engagement_screen.dart';
import 'screens/finalized_order_screen.dart';
import 'screens/order_screen.dart';
import 'screens/engagement_screen.dart';

class App extends StatelessWidget {

  static final routes = {
    MainScreen.routeName: (context) => MainScreen(),
    SelectedEngagement.routeName: (BuildContext context) => SelectedEngagement(),
    CreateNewEngagement.routeName: (context) => CreateNewEngagement(),
    NewEstimateScreen.routeName: (context) => NewEstimateScreen(),
    FinalizedOrderScreen.routeName: (context) => FinalizedOrderScreen(),
    OrderScreen.routeName: (context) => OrderScreen()
  };

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ops Normal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
    );
  }
}
