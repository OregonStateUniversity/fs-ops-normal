import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/hidable_floating_action_button.dart';
import 'active_engagement_list_screen.dart';
import 'inactive_engagement_list_screen.dart';
import '../event_handlers/floating_action_button_handler.dart';
import '../event_handlers/popup_menu_button_handler.dart';
import '../widgets/side_drawer.dart';
import '../widgets/sort_popup_menu_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var _addEngagementButtonVisible = true;

  final popupMenuButtonHandler = PopupMenuButtonHandler();
  final floatingActionButtonHandler = FloatingActionButtonHandler();

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Home', icon: Icon(Icons.home)),
    Tab(text: 'Archive', icon: Icon(Icons.archive))
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: BottomNavBar(
          leftButtonFunction: () {
            toggle();
            setState(() {});
          },
          showHome: _tabController.index == 0 ? false : true),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HidableFloatingActionButton(
          visible: _addEngagementButtonVisible,
          tooltip: "add engagement",
          onPressed: () => floatingActionButtonHandler.onPressed(),
          child: const Icon(Icons.add)),
    );
  }

  toggle() {
    _tabController.index = _tabController.index == 0 ? 1 : 0;
    _addEngagementButtonVisible = !_addEngagementButtonVisible;
  }
}
