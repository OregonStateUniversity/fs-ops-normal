import 'package:flutter/material.dart';
import 'route_map.dart';
import 'screens/active_engagement_list_screen.dart';
import 'screens/inactive_engagement_list_screen.dart';
import 'event_handlers/floating_action_button_handler.dart';
import 'event_handlers/popup_menu_button_handler.dart';
import 'widgets/hidable_floating_action_button.dart';
import 'widgets/side_drawer.dart';
import 'widgets/sort_popup_menu_button.dart';

class App extends StatelessWidget {

  static const APP_TITLE = 'Ops Normal';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      routes: RouteMap.routes,
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(color: const Color.fromRGBO(0, 80, 47, 1)),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: MainScreen()
    );
  }
  
}

class MainScreen extends StatelessWidget {

  static const tabs = [
    Tab(text: 'Home', icon: Icon(Icons.home)),
    Tab(text: 'Archive', icon: Icon(Icons.archive))
  ];

  final popupMenuButtonHandler = PopupMenuButtonHandler();
  final floatingActionButtonHandler = FloatingActionButtonHandler();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            floatingActionButton: HidableFloatingActionButton(
              visible: true,
              onPressed: () => floatingActionButtonHandler.onPressed(),
              tooltip: 'New engagement',
              child: const Icon(Icons.add)
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            drawer: SideDrawer(),
            appBar: AppBar(
                title: const Text('Ops Normal'),
                actions: [
                  SortPopupMenuButton(popupMenuButtonHandler: popupMenuButtonHandler)
                ]
            ),
            body: SafeArea(
              child: TabBarView(
                children: [
                  ActiveEngagementListScreen(
                    popupMenuButtonHandler: popupMenuButtonHandler,
                    floatingActionButtonHandler: floatingActionButtonHandler),
                  InactiveEngagementListScreen()
                ]
              )
            ),
            bottomNavigationBar: Container(
              color: Colors.blueGrey[900],
              child: TabBar(tabs: tabs, unselectedLabelColor: Colors.grey)
            )
        )
      );
  }

}
