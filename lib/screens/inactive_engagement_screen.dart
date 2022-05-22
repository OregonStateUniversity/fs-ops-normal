import 'package:flutter/material.dart';
import 'new_estimate_screen.dart';
import 'estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../persistence/database_manager.dart';
import '../persistence/estimate_dao.dart';
import '../utils/date_time_formatter.dart';
import '../widgets/bottom_nav_bar.dart';

class InactiveEngagementScreen extends StatefulWidget {
  static const routeName = 'engagement';
  final Engagement engagement;
  final List<Estimate> estimates;

  InactiveEngagementScreen(
      {Key? key, required this.engagement, required this.estimates})
      : super(key: key);

  _InactiveEngagementScreenState createState() =>
      _InactiveEngagementScreenState(estimates: this.estimates);
}

class _InactiveEngagementScreenState extends State<InactiveEngagementScreen> {
  List<Estimate> estimates;

  _InactiveEngagementScreenState({required this.estimates});

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
    if (this.estimates.isEmpty == true) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: RichText(
            text: TextSpan(
                style: TextStyle(fontSize: 22, color: Colors.white),
                children: <TextSpan>[
                  TextSpan(
                    text: "${widget.engagement.name}",
                    style: TextStyle(fontSize: 22),
                  ),
                  TextSpan(
                      text:
                          "\nCreated ${DateTimeFormatter.format(widget.engagement.createdAt)}",
                      style: TextStyle(fontSize: 14))
                ]),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No Estimates Created Yet"),
              ],
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: floatAccButton(widget.engagement),
        bottomNavigationBar: BottomNavBar(goBack: '/'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: RichText(
          text: TextSpan(
              style: TextStyle(fontSize: 22, color: Colors.white),
              children: <TextSpan>[
                TextSpan(
                  text: "${widget.engagement.name}",
                  style: TextStyle(fontSize: 22),
                ),
                TextSpan(
                    text: "\nCreated on: ${widget.engagement.createdAt}",
                    style: TextStyle(fontSize: 14))
              ]),
        ),
        actions: <Widget>[
          PopupMenuButton(
              icon: Transform.rotate(
                angle: 90 * 3.1415927 / 180,
                child: Icon(Icons.code),
              ),
              offset: Offset(0, 30),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text("Oldest"),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text("Newest"),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Text("Size"),
                    ),
                  ],
              onSelected: (dynamic value) {
                if (value == 1) {
                  setState(() {
                    this
                        .estimates
                        .sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));
                  });
                } else if (value == 2) {
                  setState(() {
                    this
                        .estimates
                        .sort((a, b) => b.timeStamp!.compareTo(a.timeStamp!));
                  });
                } else if (value == 3) {
                  setState(() {
                    this.estimates.sort((a, b) => b.acres!.compareTo(a.acres!));
                  });
                }
              }),
        ],
      ),
      body: Scrollbar(
          child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: this.estimates.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Estimate ${this.estimates[index].name}',
                      style: TextStyle(fontSize: 22)),
                  subtitle: Text(
                    '${this.estimates[index].acres.toString()} Acres\nCreated on: ${this.estimates[index].timeStamp}\n',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, EstimateScreen.routeName,
                        arguments: this.estimates[index]);
                  },
                );
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: floatAccButton(widget.engagement),
      bottomNavigationBar: BottomNavBar(goBack: '/'),
    );
  }

  Widget? floatAccButton(engagement) {
    if (engagement.active == 0) {
      return null;
    }
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, NewEstimateScreen.routeName,
            arguments: engagement);
      },
      tooltip: 'New Estimate',
      child: Icon(Icons.add),
    );
  }
}
