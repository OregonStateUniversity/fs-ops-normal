import 'package:flutter/material.dart';
import 'active_engagement_list_screen.dart';
import 'inactive_engagement_list_screen.dart';
import '../event_handlers/floating_action_button_handler.dart';
import '../event_handlers/popup_menu_button_handler.dart';
import '../widgets/hidable_floating_action_button.dart';
import '../widgets/side_drawer.dart';
import '../widgets/sort_popup_menu_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const tabs = [
    Tab(text: 'Home', icon: Icon(Icons.home)),
    Tab(text: 'Archive', icon: Icon(Icons.archive))
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final popupMenuButtonHandler = PopupMenuButtonHandler();
  final floatingActionButtonHandler = FloatingActionButtonHandler();

  final _fabVisible = true; //change "final" to "var" if adding nav bar back in

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: MainScreen.tabs.length,
        child: Scaffold(
          floatingActionButton: HidableFloatingActionButton(
              visible: _fabVisible,
              onPressed: () => floatingActionButtonHandler.onPressed(),
              tooltip: 'New engagement',
              child: const Icon(Icons.add)),
          //floatingActionButtonLocation:
              //FloatingActionButtonLocation.,
          drawer: const SideDrawer(),
          appBar: AppBar(title: const Text('Ops Normal'), actions: [
            SortPopupMenuButton(popupMenuButtonHandler: popupMenuButtonHandler)
          ]),
          body: SafeArea(
              child: TabBarView(children: [
            ActiveEngagementListScreen(
                popupMenuButtonHandler: popupMenuButtonHandler,
                floatingActionButtonHandler: floatingActionButtonHandler),
            InactiveEngagementListScreen(
              popupMenuButtonHandler: popupMenuButtonHandler,
            ),
          ])),
          /*bottomNavigationBar: Container(
                color: Colors.blueGrey[900],
                child: TabBar(
                  tabs: MainScreen.tabs,
                  unselectedLabelColor: Colors.grey,
                  onTap: (index) => setState( () => _fabVisible = (index == 0) )
                )
            )*/
        ));
  }
}
