import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'engagement_screen.dart';
import '../models/engagement.dart';
import '../persistence/database_manager.dart';
import '../persistence/engagement_dao.dart';
import '../utils/date_time_formatter.dart';
import '../widgets/bottom_icon.dart';
import '../widgets/new_engagement_dialog.dart';
import '../widgets/side_drawer.dart';

class XActiveEngagementListScreen extends StatefulWidget {
  XActiveEngagementListScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  XActiveEngagementListScreenState createState() => XActiveEngagementListScreenState();
}

class XActiveEngagementListScreenState extends State<XActiveEngagementListScreen> {
  List<Engagement>? engagements;
  var active = true;
  get _noEngagements => engagements == null || engagements!.isEmpty;

  @override
  void initState() {
    super.initState();
    loadEngagements();
  }

  void loadEngagements() async {
    if (active) {
      this.engagements = await EngagementDAO.activeEngagements(
          databaseManager: DatabaseManager.getInstance());
    } else {
      this.engagements = await EngagementDAO.inactiveEngagements(
          databaseManager: DatabaseManager.getInstance());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _bodyChildren()
    );
  }

  Widget _appBarTitle() =>
      active ? const Text("Ops Normal") : const Text("Ops Archive");

  Widget _emptyListPrompt() => active
      ? const Text("No engagements created yet.")
      : const Text("No engagements archived yet.");

  List<Widget> _appBarActions() =>
      _noEngagements ? const <Widget>[] : [_sortMenu()];

  Widget _sortMenu() {
    return PopupMenuButton(
        icon: Icon(Icons.sort),
        itemBuilder: (context) => [
              PopupMenuItem(value: 'newest', child: Text("Newest")),
              PopupMenuItem(value: 'oldest', child: Text("Oldest")),
            ],
        onSelected: (value) => _sortEngagements(value as String));
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

  List<Widget> _bodyChildren() {
    if (_noEngagements) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_emptyListPrompt()],
        )
      ];
    } else {
      return [
        Text('Engagements'),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: engagements!.length,
              itemBuilder: (context, index) =>
                  _dismissible(engagements![index])),
        ),
      ];
    }
  }

  Widget _dismissible(Engagement engagement) {
    return Dismissible(
        key: Key(engagement.id.toString()),
        background: _archiveBackground(),
        secondaryBackground: _deleteBackground(),
        dismissThresholds: {
          DismissDirection.startToEnd: 0.25,
          DismissDirection.endToStart: 0.25
        },
        confirmDismiss: (DismissDirection direction) async {
          return await _confirmDismiss(direction);
        },
        onDismissed: (direction) {
          _archiveOrDeleteEngagement(direction, engagement);
        },
        child: _listTile(engagement));
  }

  Widget _listTile(Engagement engagement) {
    return ListTile(
      title: Text(engagement.name, style: TextStyle(fontSize: 22)),
      subtitle: Text(
          'Created: ${DateTimeFormatter.format(engagement.createdAt)}',
          style: TextStyle(fontSize: 18)),
      onTap: () {
        Navigator.pushNamed(context, EngagementScreen.routeName,
            arguments: engagement);
      },
    );
  }

  Widget _archiveBackground() {
    return Stack(children: [
      Container(
        color: Colors.green,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(_archivingIconData(), color: Colors.white),
              Text(_archivingIconText(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)),
              SizedBox(width: 20)
            ],
          ),
        ),
      ),
    ]);
  }

  IconData _archivingIconData() {
    return active ? Icons.archive_rounded : Icons.unarchive_rounded;
  }

  String _archivingIconText() {
    return active ? "Archive" : "Unarchive";
  }

  Widget _deleteBackground() {
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
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          if (direction == DismissDirection.endToStart) {
            return _alertDialog("Delete");
          } else {
            return _alertDialog("Archive");
          }
        });
  }

  void _archiveOrDeleteEngagement(direction, Engagement engagement) {
    if (direction == DismissDirection.endToStart) {
      EngagementDAO.delete(
          databaseManager: DatabaseManager.getInstance(),
          engagement: engagement);
    } else if (active == true) {
      //EngagementDAO.deactivate(databaseManager: DatabaseManager.getInstance(), engagement: engagement);
    } else if (active == false) {
      EngagementDAO.reactivate(
          databaseManager: DatabaseManager.getInstance(),
          engagement: engagement);
    }
    loadEngagements();
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
            loadEngagements();
            _onTap(index);
            break;
          case 1:
            active = false;
            loadEngagements();
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
            builder: (context) => NewEngagementDialog()).then((value) {
          if (value) {
            setState(() {
              loadEngagements();
            });
          }
        });
      },
      tooltip: 'New engagement',
      child: const Icon(Icons.add),
    );
  }
}
