import 'package:flutter/material.dart';
import 'inactive_engagement_screen.dart';
import '../event_handlers/popup_menu_button_handler.dart';
import '../models/engagement.dart';
import '../persistence/database_manager.dart';
import '../persistence/engagement_dao.dart';
import '../persistence/estimate_dao.dart';
import '../utils/date_time_formatter.dart';

class InactiveEngagementListScreen extends StatefulWidget {
  InactiveEngagementListScreen({
    Key? key,
    required this.popupMenuButtonHandler,
  }) : super(key: key);

  final PopupMenuButtonHandler popupMenuButtonHandler;

  static const routeName = '/';

  @override
  InactiveEngagementListScreenState createState() =>
      InactiveEngagementListScreenState();
}

class InactiveEngagementListScreenState
    extends State<InactiveEngagementListScreen> {
  List<Engagement>? engagements;
  get _noEngagements => engagements == null || engagements!.isEmpty;

  @override
  void initState() {
    super.initState();
    loadEngagements();

    widget.popupMenuButtonHandler.onSelected = (String order) {
      if (order == 'oldest') {
        setState(() {
          engagements!.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        });
      } else if (order == 'newest') {
        setState(() {
          engagements!.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        });
      }
    };
  }

  void loadEngagements() async {
    this.engagements = await EngagementDAO.inactiveEngagements(
        databaseManager: DatabaseManager.getInstance());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center, children: _bodyChildren());
  }

  Widget _emptyListPrompt() => const Text("No engagements archived yet.");

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
        Text('Archived Engagements'),
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
      onTap: () async {
        final estimates = await EstimateDAO.estimates(databaseManager: DatabaseManager.getInstance(), engagement: engagement);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
            return InactiveEngagementScreen(engagement: engagement, estimates: estimates);
          })
        );
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
    return Icons.unarchive_rounded;
  }

  String _archivingIconText() {
    return "Unarchive";
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
    } else {
      EngagementDAO.reactivate(
          databaseManager: DatabaseManager.getInstance(),
          engagement: engagement);
    }
    loadEngagements();
  }

  Widget _alertDialog(deleteOrArchive) {
    return AlertDialog(
      title: deleteOrArchive == "Delete"
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
}
