import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hose_jockey/Widgets/bottom_nav_bar.dart';
import '../utils/time_format.dart';
import 'dart:convert';
import 'engagement_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../persistence/database_helper.dart';
import '../Widgets/drawer.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final engagementCtrl = new TextEditingController();
  final acreageCtrl = TextEditingController();
  final GlobalKey<MainScreenState> _key = GlobalKey();
  List<Engagement> engagements = [];

  var newName;
  var dto;
  var active = true; // always starts on active orders

  void initState() {
    super.initState();
    loadEngagements();
  }

  void loadEngagements() async {
    List<Map> engagementRecords = await DatabaseHelper.getAllEngagements();
    final engagementEntries = engagementRecords.map((record) {
      print("active: ${record['active']}");
      return Engagement(
        record['name'],
        record['timeStamp'],
        record['acres'],
        record['shape'],
        record['type'],
        record['structuers'],
        loadOrders(record['orders']),
        record['active'],
        record['id'],
      );
    }).toList();
    setState(() {
      active == true
          ? engagements = engagementEntries.reversed
              .toList()
              .where((a) => a.active == 1)
              .toList()
          : engagements = engagementEntries.reversed
              .toList()
              .where((a) => a.active == 0)
              .toList();
    });
  }

  List<Estimate> loadOrders(string) {
    Iterable i = json.decode(string);
    List<Estimate> orderEntries =
        List<Estimate>.from(i.map((model) => Estimate.fromJson(model)));
    return orderEntries;
  }

  void setEngagement() {
    if (engagementCtrl.text.isNotEmpty) {
      setState(() {
        dto = Engagement(
            newName, TimeFormat.currentTime, 250, 'Square', 'Timber', 0, [], 1);
      });
      engagementCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = active == true ? "Ops Normal" : "Ops Archive";
    if (engagements.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
          ),
          drawer: SideDrawer(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  active == true
                      ? Text("No Engagements Created Yet")
                      : Text("No Engagements Archived Yet")
                ],
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: floatAccButton(),
          bottomNavigationBar: bottomNavBar());
    } else
      return Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: SideDrawer(),
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
            actions: <Widget>[_sortByOptions()],
          ),
          body: Column(key: _key, children: <Widget>[
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: engagements.length,
                  itemBuilder: (context, index) {
                    return _dismissible(engagements, index);
                  }),
            ),
          ]),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: floatAccButton(),
          bottomNavigationBar: bottomNavBar());
  }

  Widget _sortByOptions() {
    return PopupMenuButton(
        icon: Transform.rotate(
          angle: 90 * 3.1415927 / 180,
          child: Icon(Icons.code),
        ),
        offset: Offset(0, 30),
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("Old"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("New"),
              ),
            ],
        onSelected: (dynamic value) {
          if (value == 1) {
            setState(() {
              engagements.sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));
            });
          } else if (value == 2) {
            setState(() {
              engagements.sort((a, b) => b.timeStamp!.compareTo(a.timeStamp!));
            });
          }
        });
  }

  Widget _dismissible(engagements, index) {
    return Dismissible(
        key: Key(engagements[index].primaryKey.toString()),
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
      subtitle: Text('Created: ${engagements[index].timeStamp}',
          style: TextStyle(fontSize: 18)),
      onTap: () {
        Navigator.pushNamed(
          context,
          SelectedEngagement.routeName,
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
      DatabaseHelper.deleteEngagement(engagements[index].primaryKey);
    } else if (active == true) {
      DatabaseHelper.archiveEngagement(engagements[index].primaryKey);
    } else if (active == false) {
      DatabaseHelper.unarchiveEngagement(engagements[index].primaryKey);
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

  _createEngagement(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Create New Engagement'),
              content: TextField(
                autofocus: true,
                controller: engagementCtrl,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Engagement Name:',
                  border: const OutlineInputBorder(),
                ),
              ),
              actions: <Widget>[
                OutlinedButton(
                  child: Text('cancel'),
                  onPressed: () {
                    engagementCtrl.clear();
                    Navigator.of(context).pop();
                  },
                ),
                OutlinedButton(
                  key: Key('create engagement'),
                  child: Text('Create'),
                  onPressed: () async {
                    newName = engagementCtrl.text;
                    setEngagement();
                    DatabaseHelper.insertEngagement(dto);
                    loadEngagements();
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }

  int? activeIndex;
  var _bottomNavIndex = 0;
  final autoSizeGroup = AutoSizeGroup();

  List<BottomIcons> iconList = [
    BottomIcons("Home", Icons.home_filled),
    BottomIcons("Archive", Icons.archive),
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
                group: autoSizeGroup,
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

  Widget? floatAccButton() {
    if (active == false) {
      return null;
    }
    return FloatingActionButton(
      key: Key("add engagement"),
      onPressed: () => _createEngagement(context),
      tooltip: 'New estimate',
      child: Icon(Icons.add),
    );
  }

  void changeBackToActive() {
    active = true;
    loadEngagements();
  }
}
