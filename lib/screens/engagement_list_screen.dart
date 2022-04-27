import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'engagement_screen.dart';
import '../models/engagement.dart';
import '../persistence/database_helper.dart';
import '../persistence/database_manager.dart';
import '../persistence/engagement_dao.dart';
import '../utils/date_time_formatter.dart';
import '../widgets/bottom_icon.dart';
import '../widgets/new_engagement_dialog.dart';
import '../widgets/side_drawer.dart';

class EngagementListScreen extends StatefulWidget {
  EngagementListScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  EngagementListScreenState createState() => EngagementListScreenState();
}

class EngagementListScreenState extends State<EngagementListScreen> {
  
  // final GlobalKey<EngagementListScreenState> _key = GlobalKey();
  List<Engagement>? engagements;
  var active = true;
  get _noEngagements => engagements == null || engagements!.isEmpty;
  
  @override
  void initState() {
    super.initState();
    loadEngagements();
  }

  void loadEngagements() async {
    this.engagements = await EngagementDAO.engagements(databaseManager: DatabaseManager.getInstance());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: _appBarTitle(),
        actions: _appBarActions(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _bodyChildren()
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: this.active ? newEngagementButton() : null,
      bottomNavigationBar: bottomNavBar()
    );
  }

  Widget _appBarTitle() => active ? const Text("Ops Normal") : const Text("Ops Archive");

  Widget _emptyListPrompt() => active ? const Text("No engagements created yet.") : const Text("No engagements archived yet.");

  List<Widget> _appBarActions() => _noEngagements ? const <Widget>[] : [_sortMenu()];

  List<Widget> _bodyChildren() {
    if (_noEngagements) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_emptyListPrompt()],
        )];
    } else {
      return [
        Text('Engagements'),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: engagements!.length,
            itemBuilder: (context, index) {
              return _dismissible(engagements, index);
            }),
          ),
        ];
    }
  }

  Widget _sortMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.sort),
      itemBuilder: (context) => [
        PopupMenuItem(value: 'newest', child: Text("Newest")),
        PopupMenuItem(value: 'oldest', child: Text("Oldest")),
      ],
      onSelected: (value) => _sortEngagements(value as String)
    );
  }

  void _sortEngagements(String order) {
    if (order == 'oldest') {
      setState(() {
        engagements!.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      });
    } else if (order == 'newest') {
      setState(() {
        engagements!.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      });
    }
  }

  Widget _dismissible(engagements, index) {
    return Dismissible(
        key: Key(engagements[index].id.toString()),
        background: _primaryBackground(),
        secondaryBackground: _secondaryBackground(),
        dismissThresholds: {
          DismissDirection.startToEnd: 0.25,
          DismissDirection.endToStart: 0.25
        },
        confirmDismiss: (DismissDirection direction) async {
          return await _confirmDismiss(direction);
        },
        onDismissed: (direction) {
          _onDismissed(direction, index);
        },
        child: _listTile(engagements, index));
  }

  Widget _listTile(engagements, index) {
    return ListTile(
      title: Text(
        '${engagements[index].name}',
        style: TextStyle(fontSize: 22),
      ),
      subtitle: Text('Created: ${DateTimeFormatter.format(engagements[index].createdAt)}',
          style: TextStyle(fontSize: 18)),
      onTap: () {
        Navigator.pushNamed(
          context,
          EngagementScreen.routeName,
          arguments: engagements[index],
        );
      },
    );
  }

  Widget _primaryBackground() {
    return Stack(children: [
      Container(
        color: Colors.green,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                  active == false
                      ? Icons.unarchive_rounded
                      : Icons.archive_rounded,
                  color: Colors.white),
              Text(active == false ? "Unarchive" : "Archive",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)),
              SizedBox(width: 20)
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _secondaryBackground() {
    return Stack(
      children: [
        Container(
          color: Colors.red,
          child: Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.delete_forever_outlined, color: Colors.white),
                Text("Delete",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
                SizedBox(width: 20)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<bool?> _confirmDismiss(direction) async {
    if (direction == DismissDirection.endToStart) {
      return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return _alertDialog("Delete");
          });
    } else {
      return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return _alertDialog("Archive");
          });
    }
  }

  void _onDismissed(direction, index) {
    if (direction == DismissDirection.endToStart) {
      DatabaseHelper.deleteEngagement(engagements![index].id);
    } else if (active == true) {
      DatabaseHelper.archiveEngagement(engagements![index].id);
    } else if (active == false) {
      DatabaseHelper.unarchiveEngagement(engagements![index].id);
    }
    // loadEngagements();
  }

  Widget _alertDialog(deleteOrArchive) {
    return AlertDialog(
      title: active == true
          ? deleteOrArchive == "Archive"
              ? Text("Archive Engagement")
              : Text("Delete Engagement")
          : deleteOrArchive == "Delete"
              ? Text("Delete Engagement")
              : Text("Unarchive"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text("Yes"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("No"),
        )
      ],
    );
  }

  var _bottomNavIndex = 0;

  List<BottomIcon> iconList = [
    BottomIcon("Home", Icons.home_filled),
    BottomIcon("Archive", Icons.archive),
  ];

  void _onTap(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget bottomNavBar() {
    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? Colors.red : Colors.white;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconList[index].icon,
              size: 24,
              color: color,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AutoSizeText(
                iconList[index].name,
                maxLines: 1,
                style: TextStyle(color: color),
                group: AutoSizeGroup(),
              ),
            )
          ],
        );
      },
      backgroundColor: (Colors.blueGrey[900]!),
      onTap: (index) {
        switch (index) {
          case 0:
            active = true;
            // loadEngagements();
            _onTap(index);
            break;
          case 1:
            active = false;
            // loadEngagements();
            _onTap(index);
            break;
        }
      },
    );
  }

  Widget newEngagementButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => NewEngagementDialog()
        ).then((value) {
          if (value) {
            setState(() { loadEngagements(); });
          }
        });    
      },
      tooltip: 'New engagement',
      child: const Icon(Icons.add),
    );
  }

}
