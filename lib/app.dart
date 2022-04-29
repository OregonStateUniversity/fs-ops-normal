import 'package:flutter/material.dart';
import 'screens/about_screen.dart';
import 'screens/new_estimate_screen.dart';
import 'screens/engagement_screen.dart';
import 'screens/estimate_screen.dart';
import 'screens/how_to_screen.dart';
import 'screens/incident_response_pocket_guide_screen.dart';
import 'screens/modify_estimate_screen.dart';
import 'screens/red_book_screen.dart';
import 'screens/xactive_engagement_list_screen.dart';
import 'screens/xinactive_engagement_list_screen.dart';
import 'widgets/side_drawer.dart';

class App extends StatelessWidget {
  static final routes = {
    AboutScreen.routeName: (context) => AboutScreen(),
    NewEstimateScreen.routeName: (context) => NewEstimateScreen(),
    EstimateScreen.routeName: (context) => EstimateScreen(),
    HowToScreen.routeName: (context) => HowToScreen(),
    IncidentResponsePocketGuideScreen.routeName: (context) =>
        IncidentResponsePocketGuideScreen(),
    ModifyEstimateScreen.routeName: (context) => ModifyEstimateScreen(),
    EngagementScreen.routeName: (context) => EngagementScreen(),
    RedBookScreen.routeName: (context) => RedBookScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ops Normal',
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(color: const Color.fromRGBO(0, 80, 47, 1)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen()
    );
  }
}

class MainScreen extends StatelessWidget {
  
  final Widget sortMenu = PopupMenuButton(
        icon: Icon(Icons.sort),
        itemBuilder: (context) => [
              PopupMenuItem(value: 'newest', child: const Text('Newest')),
              PopupMenuItem(value: 'oldest', child: const Text('Oldest')),
            ],
        onSelected: (value) => { /* TODO */ });

  static const tabs = [
    Tab(text: 'Home', icon: Icon(Icons.home)),
    Tab(text: 'Archive', icon: Icon(Icons.archive))
  ];

  static final screens = [
    XActiveEngagementListScreen(),
    XInactiveEngagementListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            drawer: SideDrawer(),
            appBar: AppBar(
                title: const Text('Ops Normal'),
                actions: [sortMenu],
            ),
            body: SafeArea(child: TabBarView(children: screens)),
            bottomNavigationBar: Container(
              color: Colors.blueGrey[900],
              child: TabBar(tabs: tabs, unselectedLabelColor: Colors.grey)
            )
        )

      );
  }

}

