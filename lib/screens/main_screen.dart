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

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Home', icon: Icon(Icons.home)),
    Tab(text: 'Archive', icon: Icon(Icons.archive))
  ];

  late TabController _tabController;
  var _fabVisible = true; //change "final" to "var" if adding nav bar back in

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final popupMenuButtonHandler = PopupMenuButtonHandler();
  final floatingActionButtonHandler = FloatingActionButtonHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: _fabVisible ? 220 : 0),
            child: FloatingActionButton(
              onPressed: () {
                _tabController.index = _tabController.index == 0 ? 1 : 0;
                setState(() {
                  _fabVisible = !_fabVisible;
                });
              },
              tooltip: "toggle home or archive",
              heroTag: "homeButton",
              child: _fabVisible
                  ? const Icon(Icons.archive)
                  : const Icon(Icons.home),
            ),
          ),
          HidableFloatingActionButton(
              visible: _fabVisible,
              onPressed: () => floatingActionButtonHandler.onPressed(),
              tooltip: 'New engagement',
              child: const Icon(Icons.add)),
        ],
      ),
      drawer: const SideDrawer(),
      appBar: AppBar(title: const Text('Ops Normal'), actions: [
        SortPopupMenuButton(popupMenuButtonHandler: popupMenuButtonHandler)
      ]),
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            ActiveEngagementListScreen(
                popupMenuButtonHandler: popupMenuButtonHandler,
                floatingActionButtonHandler: floatingActionButtonHandler),
            InactiveEngagementListScreen(
                popupMenuButtonHandler: popupMenuButtonHandler),
          ]),
      /*bottomNavigationBar: Container(
            color: Colors.blueGrey[900],
            child: TabBar(
                controller: _tabController,
                tabs: tabs,
                unselectedLabelColor: Colors.grey,
                onTap: (index) => setState(() => _fabVisible = (index == 0))))*/
    );
  }
}
