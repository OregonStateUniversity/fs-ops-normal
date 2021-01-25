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
          automaticallyImplyLeading: false,
          title: Text("${engagement.name}"),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("$engagement from engagement_screen");
            Navigator.pushNamed(context, NewEstimateScreen.routeName, arguments: engagement).then((value) => setState((){}));
          },
          tooltip: 'New Order',
          child: Icon(Icons.add),
        ),

        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(icon: Icon(Icons.home), onPressed: (){Navigator.popUntil(context, ModalRoute.withName('/'));},),
              FlatButton(
                onPressed: (){
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: Text("Back"),
              )
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("$engagement from engagement_screen");
          Navigator.pushNamed(context, NewEstimateScreen.routeName, arguments: engagement).then((value) => setState((){}));
        },
        tooltip: 'New Order',
        child: Icon(Icons.add),
      ),

      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(icon: Icon(Icons.home), onPressed: (){Navigator.popUntil(context, ModalRoute.withName('/'));},),
            FlatButton(
              onPressed: (){
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text("Back"),
            )
          ],
        ),
      ),
    );
  }
}