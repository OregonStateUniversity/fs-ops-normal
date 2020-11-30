import 'package:flutter/material.dart';
import 'new_estimate_screen.dart';
import 'finalized_order_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("${engagement.name}"),
      ),
      body: Scrollbar(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: orders.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text('Order ${orders.length - index}'),
              subtitle: Text('${orders[index].acres.toString()} Acres\nCreate on: ${orders[index].timeStamp}\n'),
              onTap: () {
                Navigator.pushNamed(context, FinalizedOrderScreen.routeName, arguments: orders[index]);
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