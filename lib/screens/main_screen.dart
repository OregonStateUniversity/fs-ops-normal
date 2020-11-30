import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hose_jockey/time_format.dart';
import 'engagement_screen.dart';
import 'new_engagement_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);
  static const routeName = '/';

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {

  TextEditingController engagementCtrl = TextEditingController();
  TextEditingController acreageCtrl = TextEditingController();
  final GlobalKey<MainScreenState> _key = GlobalKey();


  List<Engagement> engagements = [
    Engagement('Bravo Engagement', '10-23-20', 500, []),
    Engagement('Gamma Engagement', '10-23-20', 500, [Estimate.loadSavedEstimate("name", 15, timeFormat(), 100, 110, 100)]),
    Engagement('Alpha Engagement', '10-23-20', 500, [Estimate(name: "Order 3", timeStamp: timeFormat(), acres: 50),Estimate(name: "Order 2", timeStamp: timeFormat(), acres: 400),Estimate(name: "Order 1", timeStamp: timeFormat(), acres: 1),Estimate(name: "Order 0", timeStamp: timeFormat(), acres: 2),]),
  ];

  void setEngagement(Engagement engagement) {
    engagements.add(engagement);
  }

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

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Column(
          key: _key,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: engagements.length,
                itemBuilder: (context, index){
                  return ListTile(
                      title: Text('${engagements[index].name}'),
                      subtitle: Text('Created: ${engagements[index].fireTimeStamp}    Acreage: ${engagements[index].size}'),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String newVal) {
                          _popBtnSelectVal = newVal;
                          Scaffold.of(context).showSnackBar(
                            SnackBar( content: Text(_popBtnSelectVal)),
                          );
                        },
                        itemBuilder: (BuildContext context) => _popUpMenuItems,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, SelectedEngagement.routeName, arguments: engagements[index]);
                      },
                  );
                }
              )
            )
          ]
        ),
        
        floatingActionButton: FloatingActionButton(	
          onPressed: () => _createEngagement(context),
          tooltip: 'New estimate',	
          child: Icon(Icons.add),	
        )
    );
  }

  _createEngagement(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create New Engagement'),
          content: TextField(
            controller: engagementCtrl,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Engagement Name:',
              border: const OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            OutlineButton(
              child: Text('cancel'),
              onPressed:() {
                Navigator.of(context).pop();
              },
            ),
            OutlineButton(
              child: Text('Create'),
              onPressed: () {
                _key.currentState
                    .setEngagement(Engagement(
                      engagementCtrl.text,
                      '10-23-20',
                      250,
                      [],
                    ));
                setState(() {

                });
                Navigator.of(context).pop();
              },
            )
          ]
        );
      }
    );
  }

}
