import 'package:flutter/material.dart';
import 'new_estimate_screen.dart';
import 'estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';


class SelectedEngagement extends StatefulWidget{

  static const routeName = 'engagement';

  _SelectedEngagementState createState() => _SelectedEngagementState();

}

class _SelectedEngagementState extends State<SelectedEngagement> {

  @override
  Widget build(BuildContext context) {

    final Engagement engagement = ModalRoute.of(context).settings.arguments;
    print("$engagement from engagement_screen modalroute arg");
    final List<Estimate> argOrders = engagement.orders;

    List<Estimate> orders = argOrders.reversed.toList();
    if(orders.isEmpty){
      return Scaffold(
        appBar: AppBar(
          title: Text("${engagement.name}"),
          centerTitle: true,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("$engagement from engagement_screen");
            Navigator.pushNamed(context, NewEstimateScreen.routeName, arguments: engagement).then((value) => setState((){}));
          },
          tooltip: 'New Order',
          child: Icon(Icons.add),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("${engagement.name}"),
      ),
      body: Scrollbar(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: orders.length,
          itemBuilder: (context, index){
            print("${orders[index].timeStamp}");
            print("${orders[index].acres}");
            return ListTile(
              title: Text('Estimate ${orders.length - index}'),
              subtitle: Text('${orders[index].acres.toString()} Acres\nCreate on: ${orders[index].timeStamp}\n'),
              onTap: () {
                Navigator.pushNamed(context, EstimateScreen.routeName, arguments: orders[index]);
              },
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("$engagement from engagement_screen");
          Navigator.pushNamed(context, NewEstimateScreen.routeName, arguments: engagement).then((value) => setState((){}));
        },
        tooltip: 'New Order',
        child: Icon(Icons.add),
      ),
    );
  }
}