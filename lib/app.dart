import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/new_estimate.dart';
import 'screens/create_new_engagement_screen.dart';
import 'screens/finalized_order.dart';
import 'screens/results_screen.dart';
import 'screens/selected_engagement.dart';

class App extends StatelessWidget {

  static final routes = {
    '/': (context) => MainScreen(),
    'engagement': (context) => SelectedEngagement(),
    'newEngagement': (context) => CreateNewEngagement(),
    'newEstimate': (context) => NewEstimateScreen(),
    //'order': (context) => FinalizedOrder(),
    'newResults': (context) => NewResultsScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ops Normal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
    );
  }
}
