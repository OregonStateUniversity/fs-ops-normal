import 'package:flutter/material.dart';
import 'package:hose_jockey/database_helper.dart';
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
    final List<Estimate> argOrders = engagement.orders;

    //List<Estimate> orders = argOrders.reversed.toList();
    List<Estimate> orders = argOrders;
    if(orders.isEmpty){
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 20, color: Colors.white),
              children: <TextSpan> [
                TextSpan(
                  text: "${engagement.name}",
                  style: TextStyle(fontSize: 20),
                ),
                TextSpan(
                  text: "\nCreated on: ${engagement.fireTimeStamp}",
                  style: TextStyle(fontSize: 14)
                )
              ]
            ),
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
        bottomNavigationBar: bottomNavBar(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
              style: TextStyle(fontSize: 20, color: Colors.white),
              children: <TextSpan> [
                TextSpan(
                  text: "${engagement.name}",
                  style: TextStyle(fontSize: 20),
                ),
                TextSpan(
                    text: "\nCreated on: ${engagement.fireTimeStamp}",
                    style: TextStyle(fontSize: 14)
                )
              ]
          ),
        ),
      ),

      body: Scrollbar(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(engagement.orders[index].timeStamp),
              background: Stack(
                children: [
                  Container(color: Colors.red,),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.delete_forever, size: 34),
                    ),
                  )
                ],
              ),
              dismissThresholds: {
                DismissDirection.startToEnd: 1.0,
                DismissDirection.endToStart: 0.25
              },
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Delete Order?"),
                        content: const Text("This cannot be undone"),
                        actions: [
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Delete"),
                          ),
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Cancel"),
                          )
                        ],
                      );
                    }
                );
              },
              onDismissed: (direction) async{
                DatabaseHelper.deleteOrder(engagement, engagement.orders[index]);
                setState((){
                  orders.removeAt(index);
                });
              },
              child: ListTile(
                title: Text('Estimate ${orders.length - index}'),
                subtitle: Text('${orders[index].acres
                    .toString()} Acres\nCreated on: ${orders[index].timeStamp}\n'),
                onTap: () {
                  Navigator.pushNamed(context, EstimateScreen.routeName,
                      arguments: orders[index]);
                },
              ),
            );
          }
          )
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: floatAccButton(engagement),
      bottomNavigationBar: bottomNavBar()
    );
  }

  Widget bottomNavBar(){
    return BottomAppBar(
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
    );
  }

  Widget floatAccButton(engagement){
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, NewEstimateScreen.routeName, arguments: engagement).then((value) => setState((){}));
      },
      tooltip: 'New Order',
      child: Icon(Icons.add),
    );
  }
}