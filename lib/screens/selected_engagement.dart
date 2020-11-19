import 'package:flutter/material.dart';
import 'new_estimate.dart';
import '../models/order.dart';

// TODO: Remove these
import 'results_screen.dart';
import '../models/estimate.dart';



class SelectedEngagement extends StatefulWidget{

  static const routeName = 'engagement';

  _SelectedEngagementState createState() => _SelectedEngagementState();

}

class _SelectedEngagementState extends State<SelectedEngagement> {

  List tmpOrders = [
    Estimate(name: "Order 3", acres: 12, timeStamp: DateTime.now().toString()),
    Estimate(name: "Order 2", acres: 120, timeStamp: DateTime.now().toString()),
    Estimate(name: "Order 1", acres: 50, timeStamp: DateTime.now().toString()),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Name of Engagegment"),
      ),
      body: Scrollbar(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: tmpOrders.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text('${tmpOrders[index].name}'),
              subtitle: Text('${tmpOrders[index].acres.toString()} Acres\nCreate on: ${tmpOrders[index].timeStamp}\n'),
              onTap: () {
                // TODO: show saved item from here this is temporary
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewResultsScreen(acreage: tmpOrders[index].acres.toString(),))
                );
              },
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewEstimateScreen()),
          );
        },
        tooltip: 'New Order',
        child: Icon(Icons.add),
      ),
    );
  }
}