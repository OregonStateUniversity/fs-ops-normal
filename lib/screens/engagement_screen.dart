import 'package:flutter/material.dart';
import 'package:hose_jockey/time_format.dart';
import 'package:hose_jockey/database_helper.dart';
import '../Widgets/ru_bottom_nav_bar.dart';
import 'estimate_screen.dart';
import 'modify_estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';

String dropdownValue = 'Timber';
String dropdownValue2 = 'Shape';

class SelectedEngagement extends StatefulWidget {
  static const routeName = 'engagement';

  _SelectedEngagementState createState() => _SelectedEngagementState();
}

class _SelectedEngagementState extends State<SelectedEngagement> {
  var _acreage = '0';
  bool _validate = false;
  final acreageCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Engagement engagement = ModalRoute.of(context).settings.arguments;
    final List<Estimate> argOrders = engagement.orders;
    List<Estimate> orders = argOrders;
    if (orders.isEmpty) {
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
        bottomNavigationBar: RU_BottomNavBar(goBack: '/'),
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
                      child: Text("Old"),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text("New"),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Text("Size"),
                    ),
                  ],
              onSelected: (value) {
                if (value == 1) {
                  setState(() {
                    orders.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
                  });
                } else if (value == 2) {
                  setState(() {
                    orders.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
                  });
                } else if (value == 3) {
                  setState(() {
                    orders.sort((a, b) => b.acres.compareTo(a.acres));
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
                  key: Key(engagement.orders[index].timeStamp),
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
                            return null;
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
                        engagement, engagement.orders[index]);
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
      bottomNavigationBar: RU_BottomNavBar(goBack: '/'),
    );
  }

  _createOrder(context) {
    final Engagement engagement = ModalRoute.of(context).settings.arguments;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Create New Order'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    controller: acreageCon,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Acreage',
                      border: const OutlineInputBorder(),
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      hintText: 'Acreage',
                    ),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = "Defualt";
                      });
                    },
                    items: <String>['Timber', 'Grass']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue2,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = "Defualt";
                      });
                    },
                    items: <String>['Shape', 'ShapeTwo']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              actions: <Widget>[
                OutlineButton(
                  child: Text('cancel'),
                  onPressed: () {
                    acreageCon.clear();
                    Navigator.of(context).pop();
                  },
                ),
                OutlineButton(
                  child: Text('Calculate Estimate'),
                  onPressed: () {
                    setState(() {
                      acreageCon.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                      _acreage = acreageCon.text;
                    });

                    var estimate = new Estimate(
                        acres: int.parse(_acreage),
                        timeStamp: TimeFormat.currentTime);
                    estimate.initialLineCalculation();
                    acreageCon.clear();
                    _acreage.isNotEmpty
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ModifyEstimateScreen(
                                      estimate: estimate,
                                      engagement: engagement,
                                    )),
                          )
                        : ArgumentError.notNull('Value Can\'t Be Empty');
                  },
                )
              ]);
        });
  }

  Widget floatAccButton(engagement) {
    if (engagement.active == 0) {
      return null;
    }
    return FloatingActionButton(
      onPressed: () => _createOrder(context).then((value) => setState(() {})),
      tooltip: 'New Order',
      child: Icon(Icons.add),
    );
  }
}
