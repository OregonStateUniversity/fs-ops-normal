import 'package:flutter/material.dart';
import 'new_estimate.dart';

// TODO: Remove these
import 'results_screen.dart';
import '../models/estimate.dart';

class Order{
  String name;
  String timeStamp;
  Estimate estimate;

  Order(this.name, this.timeStamp, this.estimate);

}

class SelectedEngagement extends StatefulWidget{

  _SelectedEngagementState createState() => _SelectedEngagementState();

}

class _SelectedEngagementState extends State<SelectedEngagement> {

  List orders = [
    Order('Order 1', new DateTime.now().toString(), Estimate(acres: 12)),
    Order('Order 2', new DateTime.now().toString(), Estimate(acres: 25)),
    Order('Order 3', new DateTime.now().toString(), Estimate(acres: 50)),
  ];


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Name of Engagegment"),
        ),
        body: Scrollbar(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: orders.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text('${orders[index].name}'),
                subtitle: Text('${orders[index].estimate.acres.toString()} Acres\n${orders[index].timeStamp}\n'),
                onTap: () {
                  // TODO: show saved item from here this is temporary
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewResultsScreen(acreage: orders[index].estimate.acres.toString(),))
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
      )
    );
  }
}