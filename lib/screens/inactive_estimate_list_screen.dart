import 'package:flutter/material.dart';
import 'estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../persistence/database_manager.dart';
import '../persistence/estimate_dao.dart';
import '../utils/date_time_formatter.dart';
//import '../widgets/bottom_nav_bar.dart';

class InactiveEstimateListScreen extends StatefulWidget {
  static const routeName = 'engagement';
  final Engagement engagement;
  final List<Estimate> estimates;

  const InactiveEstimateListScreen(
      {Key? key, required this.engagement, required this.estimates})
      : super(key: key);

  @override
  State<InactiveEstimateListScreen> createState() {
    return _InactiveEstimateListScreenState();
  }
}

class _InactiveEstimateListScreenState
    extends State<InactiveEstimateListScreen> {
  late List<Estimate> estimates = widget.estimates;

  //_InactiveEstimateListScreenState({required this.estimates});

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                        .sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));
                  });
                } else if (value == 2) {
                  setState(() {
                    estimates
                        .sort((a, b) => b.timeStamp!.compareTo(a.timeStamp!));
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
                return ListTile(
                  title: Text('Estimate ${estimates[index].name}',
                      style: const TextStyle(fontSize: 22)),
                  subtitle: Text(
                    '${estimates[index].acres.toString()} Acres\nCreated on: ${estimates[index].timeStamp}\n',
                    style: const TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, EstimateScreen.routeName,
                        arguments: estimates[index]);
                  },
                );
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //bottomNavigationBar: const BottomNavBar(goBack: '/'),
    );
  }
}
