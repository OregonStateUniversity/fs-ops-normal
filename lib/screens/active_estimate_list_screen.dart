import 'package:flutter/material.dart';
import 'compass_screen.dart';
import 'new_estimate_screen.dart';
import 'estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../persistence/database_manager.dart';
import '../persistence/estimate_dao.dart';
import '../utils/date_time_formatter.dart';
//import '../widgets/bottom_nav_bar.dart';

class ActiveEstimateListScreen extends StatefulWidget {
  static const routeName = 'engagement';
  final Engagement engagement;
  final List<Estimate> estimates;

  const ActiveEstimateListScreen(
      {Key? key, required this.engagement, required this.estimates})
      : super(key: key);

  @override
  State<ActiveEstimateListScreen> createState() {
    return _ActiveEstimateListScreenState();
  }
}

class _ActiveEstimateListScreenState extends State<ActiveEstimateListScreen> {
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
    if (estimates.isEmpty == true) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
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
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("No Estimates Created Yet"),
                ],
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          //floatingActionButton: floatAccButton(widget.engagement),
          floatingActionButton: buttonsWrap(widget.engagement)
          //bottomNavigationBar: const BottomNavBar(goBack: '/'),
          );
    }
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
                    text: "\nCreated on: ${widget.engagement.createdAt}",
                    style: const TextStyle(fontSize: 14))
              ]),
        ),
        actions: <Widget>[
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
                    estimates
                        .sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
                  });
                } else if (value == 2) {
                  setState(() {
                    estimates
                        .sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
                  });
                } else if (value == 3) {
                  setState(() {
                    estimates.sort((a, b) => b.acres!.compareTo(a.acres!));
                  });
                }
              }),
        ],
      ),
      body: Scrollbar(
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
                      Navigator.pushNamed(context, EstimateScreen.routeName,
                              arguments:
                                  EstimateScreenArgs(false, estimates[index]))
                          .then((value) {
                        loadEstimates();
                      });
                    },
                  ),
                );
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floatingActionButton: floatAccButton(widget.engagement),
      // floatingActionButton: buttonsWrap(widget.engagement)
      floatingActionButton: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Color.fromARGB(67, 255, 255, 255))
            ],
            borderRadius: BorderRadius.circular(50),
            color: const Color.fromARGB(32, 133, 131, 131)),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            floatAccButton(widget.engagement)!,
            homeButton()!,
            FloatingActionButton(
              heroTag: 'compassButton',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CompassWidget(
                      buildNavBar: true,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.explore_outlined),
            )
          ],
        ),
      ),
      //bottomNavigationBar: const BottomNavBar(goBack: '/'),
    );
  }

  Widget? floatAccButton(engagement) {
    if (engagement.active == 0) {
      return null;
    }
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, NewEstimateScreen.routeName,
                arguments: engagement)
            .then((value) {
          loadEstimates();
        });
      },
      tooltip: 'New Estimate',
      child: const Icon(Icons.add),
    );
  }

  Widget? homeButton() {
    return FloatingActionButton(
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('/'));
          setState(() {});
        },
        heroTag: 'homeButton',
        child: const Icon(Icons.home));
  }

  Widget? buttonsWrap(engagement) {
    return Wrap(
        //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(right: 220.0),
              child: homeButton()), //button first

          Container(child: floatAccButton(engagement)), // button second,
        ]);
  }
}
