import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'new_estimate_screen.dart';
import 'estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../persistence/database_manager.dart';
import '../persistence/estimate_dao.dart';
import '../utils/date_time_formatter.dart';

class EstimateListScreen extends StatefulWidget {
  static const routeName = 'engagement';
  final Engagement engagement;
  final List<Estimate> estimates;
  final bool isActive;

  const EstimateListScreen(
      {Key? key,
      required this.engagement,
      required this.estimates,
      required this.isActive})
      : super(key: key);

  @override
  State<EstimateListScreen> createState() {
    return _EstimateListScreenState();
  }
}

class _EstimateListScreenState extends State<EstimateListScreen> {
  late List<Estimate> estimates = widget.estimates;

  @override
  void initState() {
    super.initState();
  }

  void loadEstimates() {
    EstimateDAO.estimates(
            databaseManager: DatabaseManager.getInstance(),
            engagement: widget.engagement)
        .then((estimates) {
      setState(() {
        this.estimates = estimates;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: RichText(
            text: TextSpan(
                style: const TextStyle(fontSize: 22, color: Colors.white),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.engagement.name,
                    style: const TextStyle(fontSize: 22),
                  ),
                  TextSpan(
                      text:
                          "\nCreated ${DateTimeFormatter.format(widget.engagement.createdAt)}",
                      style: const TextStyle(fontSize: 14))
                ]),
          ),
          actions: estimates.isEmpty
              ? null
              : <Widget>[
                  PopupMenuButton(
                      icon: Transform.rotate(
                        angle: 90 * 3.1415927 / 180,
                        child: const Icon(Icons.code),
                      ),
                      offset: const Offset(0, 30),
                      itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 1,
                              child: Text("Oldest"),
                            ),
                            const PopupMenuItem(
                              value: 2,
                              child: Text("Newest"),
                            ),
                            const PopupMenuItem(
                              value: 3,
                              child: Text("Size"),
                            ),
                          ],
                      onSelected: (dynamic value) {
                        if (value == 1) {
                          setState(() {
                            estimates.sort(
                                (a, b) => a.createdAt!.compareTo(b.createdAt!));
                          });
                        } else if (value == 2) {
                          setState(() {
                            estimates.sort(
                                (a, b) => b.createdAt!.compareTo(a.createdAt!));
                          });
                        } else if (value == 3) {
                          setState(() {
                            estimates
                                .sort((a, b) => b.acres!.compareTo(a.acres!));
                          });
                        }
                      }),
                ],
        ),
        body: estimates.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("No Estimates Created Yet"),
                    ],
                  )
                ],
              )
            : Scrollbar(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: estimates.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(estimates[index].createdAt.toString()),
                        background: Stack(
                          children: [
                            Container(color: Colors.red),
                            const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.delete_forever, size: 34)),
                            )
                          ],
                        ),
                        dismissThresholds: const {
                          DismissDirection.startToEnd: 2.0,
                          DismissDirection.endToStart: .25
                        },
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Delete Estimate?"),
                                  content: const Text("This cannot be undone"),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("Delete"),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("Cancel"),
                                    )
                                  ],
                                );
                              });
                        },
                        onDismissed: (direction) async {
                          EstimateDAO.delete(
                              databaseManager: DatabaseManager.getInstance(),
                              estimate: estimates[index]);
                          setState(() {
                            estimates.removeAt(index);
                          });
                        },
                        child: ListTile(
                          title: Text('Estimate ${estimates[index].id}',
                              style: const TextStyle(fontSize: 22)),
                          subtitle: Text(
                            '${estimates[index].acres.toString()} Acres\nCreated on: ${DateTimeFormatter.format(estimates[index].createdAt!)}\n',
                            style: const TextStyle(fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                    context, EstimateScreen.routeName,
                                    arguments: EstimateScreenArgs(
                                        false, estimates[index]))
                                .then((value) {
                              loadEstimates();
                            });
                          },
                        ),
                      );
                    })),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: widget.isActive
            ? FloatingActionButton(
                onPressed: () => addEstimate(), child: const Icon(Icons.add))
            : null,
        bottomNavigationBar: const BottomNavBar());
  }

  addEstimate() {
    Navigator.pushNamed(context, NewEstimateScreen.routeName,
            arguments: widget.engagement)
        .then((value) {
      loadEstimates();
      setState(() {});
    });
  }
}
