import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/new_estimate.dart';
import 'screens/create_new_engagement_screen.dart';
import 'screens/finalized_order.dart';
import 'screens/results_screen.dart';
import 'screens/selected_engagement.dart';

class App extends StatelessWidget {

//   routes: <String, WidgetBuilder> {
//       '/a': (BuildContext context) => MyPage(title: 'page A'),
//       '/b': (BuildContext context) => MyPage(title: 'page B'),
//       '/c': (BuildContext context) => MyPage(title: 'page C'),
//     },
//   ));
// }
// To show a route by name:

// Navigator.pushNamed(context, '/b');

  static final routes = {
    MainScreen.routeName: (context) => MainScreen(),
    //SelectedEngagement.routeName: (BuildContext context) => SelectedEngagement(),
    CreateNewEngagement.routeName: (context) => CreateNewEngagement(),
    NewEstimateScreen.routeName: (context) => NewEstimateScreen(),
    //'order': (context) => FinalizedOrder(),
    NewResultsScreen.routeName: (context) => NewResultsScreen()
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
