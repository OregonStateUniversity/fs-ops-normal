import 'package:flutter/material.dart';
import 'new_estimate_screen.dart';
import 'estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../persistence/database_helper.dart';
import '../widgets/bottom_nav_bar.dart';

class EngagementScreen extends StatefulWidget {
  static const routeName = 'engagement';

  _EngagementScreenState createState() => _EngagementScreenState();
}

class _EngagementScreenState extends State<EngagementScreen> {
  final acreageCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Engagement? engagement =
        ModalRoute.of(context)!.settings.arguments as Engagement?;
    final List<Estimate>? argOrders = engagement!.orders;
    List<Estimate> orders = argOrders!;
    if (orders.isEmpty) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: RichText(
            text: TextSpan(
                style: TextStyle(fontSize: 22, color: Colors.white),
                children: <TextSpan>[
                  TextSpan(
                    text: "${engagement.name}",
                    style: TextStyle(fontSize: 22),
                  ),
                  TextSpan(
                      text: "\nCreated on: ${engagement.timeStamp}",
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
                Text("No Orders Created Yet"),
              ],
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: floatAccButton(engagement),
        bottomNavigationBar: BottomNavBar(goBack: '/'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
              style: TextStyle(fontSize: 22, color: Colors.white),
              children: <TextSpan>[
                TextSpan(
                  text: "${engagement.name}",
                  style: TextStyle(fontSize: 22),
                ),
                TextSpan(
                    text: "\nCreated on: ${engagement.timeStamp}",
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
                    orders.sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));
                  });
                } else if (value == 2) {
                  setState(() {
                    orders.sort((a, b) => b.timeStamp!.compareTo(a.timeStamp!));
                  });
                } else if (value == 3) {
                  setState(() {
                    orders.sort((a, b) => b.acres!.compareTo(a.acres!));
                  });
                }
              }),
        ],
      ),
      body: Scrollbar(
          child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(engagement.orders![index].timeStamp!),
                  background: Stack(
                    children: [
                      Container(
                        color: engagement.active == 1
                            ? Colors.red
                            : Colors.black12,
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: engagement.active == 1
                              ? Icon(Icons.delete_forever, size: 34)
                              : Text("Can't Delete Orders In Archive Mode"),
                        ),
                      )
                    ],
                  ),
                  dismissThresholds: {
                    DismissDirection.startToEnd: 2.0,
                    DismissDirection.endToStart:
                        engagement.active == 1 ? .25 : 2.0
                  },
                  confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          if (engagement.active == 0) {
                            return AlertDialog(
                                title:
                                    const Text("This engagement isn't active"));
                          }
                          return AlertDialog(
                            title: const Text("Delete Order?"),
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
                    DatabaseHelper.deleteOrder(
                        engagement, engagement.orders![index]);
                    setState(() {
                      orders.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: Text('Estimate ${orders[index].name}',
                        style: TextStyle(fontSize: 22)),
                    subtitle: Text(
                      '${orders[index].acres.toString()} Acres\nCreated on: ${orders[index].timeStamp}\n',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, EstimateScreen.routeName,
                          arguments: orders[index]);
                    },
                  ),
                );
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: floatAccButton(engagement),
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
      tooltip: 'New Order',
      child: Icon(Icons.add),
    );
  }
}
