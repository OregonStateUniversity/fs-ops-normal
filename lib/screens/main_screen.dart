import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'selected_engagement.dart';
import 'create_new_engagement_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
//import 'results_screen.dart';

//class Fire {
//  String name;
//  String fireTimeStamp;
//  int size;
//  List<Estimate> orders;
//
//  Fire(this.name, this.fireTimeStamp, this.size, this.orders);
//
//  @override
//  String toString() {
//    return '{ ${this.name}, ${this.fireTimeStamp}, ${this.size} }';
//  }
//}

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);
  static const routeName = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List engagement = [
    Engagement('Bravo Engagement', '10-23-20', 500, []),
    Engagement('Gamma Engagement', '10-23-20', 500, [Estimate(name: "Order 1", timeStamp: DateTime.now().toString(), acres: 15)]),
    Engagement('Alpha Engagement', '10-23-20', 500, [Estimate(name: "Order 3", timeStamp: DateTime.now().toString(), acres: 50),Estimate(name: "Order 2", timeStamp: DateTime.now().toString(), acres: 400),Estimate(name: "Order 1", timeStamp: DateTime.now().toString(), acres: 1),Estimate(name: "Order 0", timeStamp: DateTime.now().toString(), acres: 1000),]),
  ];
  
  static const menuItems = <String>[
    'Edit',
    'Close(Mark \'Old\')',
    'Delete',
  ];

  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _popBtnSelectVal;

  @override
  Widget build(BuildContext context) {
    final title = 'Ops Normal';    
    
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Scrollbar(
          child: ListView.builder(
            //padding: const EdgeInsets.all(8),
            itemCount: engagement.length,
            itemBuilder: (context, index){
              return ListTile(
                  title: Text('${engagement[index].name}'),
                  subtitle: Text('Created: ${engagement[index].fireTimeStamp}    Acreage: ${engagement[index].size}'),
                  trailing: PopupMenuButton<String>(
                    onSelected: (String newVal) {
                      _popBtnSelectVal = newVal;
                      Scaffold.of(context).showSnackBar(
                        SnackBar( content: Text(_popBtnSelectVal)),
                      );
                    },
                    itemBuilder: (BuildContext context) => _popUpMenuItems,
                  ),
                  //onTap: () {Navigator.pushNamed(context,SelectedEngagement.routeName);},
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectedEngagement(engagement[index].orders)),
                    );
                  },
              );
            },
          )
        ),
        
        floatingActionButton: FloatingActionButton(	
          //onPressed: () {Navigator.of(context).pushNamed(CreateNewEngagement.routeName);},
           onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateNewEngagement()),
            );
          },
          tooltip: 'New estimate',	
          child: Icon(Icons.add),	
        )
      )
    );
  }
}
