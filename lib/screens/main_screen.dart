import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hose_jockey/time_format.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
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

  final engagementCtrl = new TextEditingController();
  final acreageCtrl = TextEditingController();
  final GlobalKey<MainScreenState> _key = GlobalKey();

  var newName;
  List<Engagement> engagements = [];

  void initState(){
    super.initState();
    loadEngagements();
  }

  var dto;

  void loadEngagements() async{
    final Database database = await openDatabase(
        'engagements.db', version: 1, onCreate: (Database db, int version) async{
      await db.execute(
          'CREATE TABLE IF NOT EXISTS engagements(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, timeStamp TEXT NOT NULL, acres INTEGER NOT NULL, orders TEXT NOT NULL);'
      );
    });
    List<Map> engagementRecords = await database.rawQuery('SELECT * FROM engagements');
    if (engagementRecords != null) {
      final engagementEntries = engagementRecords.map((record) {
        return Engagement(
          record['name'],
          record['timeStamp'],
          record['acres'],
          loadOrders(record['orders']),
          record['id'],
        );
      }).toList();
      setState(() {
        engagements = engagementEntries;
      });
    } else{
      engagements = new List<Engagement>();
    }
  }

  List<Estimate> loadOrders(string) {
    Iterable i = json.decode(string);
    List<Estimate> orderEntries = List<Estimate>.from(i.map((model) => Estimate.fromJson(model)));
    return orderEntries;
  }

  void deleteDB() async{
    await deleteDatabase('engagements.db'); //delete this
    print("Database deleted");
    loadEngagements();
  }

  void setEngagement() {
    if (engagementCtrl.text.isNotEmpty) {
      setState(() {
        engagements.add(
            dto = Engagement( newName, timeFormat(), 250, [] )
        );
      });
      engagementCtrl.clear();
    }
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
    if (engagements.isEmpty){
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No Engagements Created Yet"),
              ],
            ),
            FlatButton(
              //TODO: Remove entire db delete button
              child: Text("Hold To Clear All Entreries"),
              onLongPress: deleteDB,
            ),
          ],

        ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _createEngagement(context),
            tooltip: 'New estimate',
            child: Icon(Icons.add),
          ),
      );
    } else
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
                padding: const EdgeInsets.all(10),
                itemCount: engagements.length,
                itemBuilder: (context, index){
                  return ListTile(
                      title: Text('${engagements[index].name}'),
                      subtitle: Text('Created: ${engagements[index].fireTimeStamp}'),
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
              ),
            ),
            Divider(),
            FlatButton(
              //TODO: Remove entire db delete button
              child: Text("Hold To Clear All Entreries"),
              onLongPress: deleteDB,
            ),
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
              onPressed: () async {
                newName = engagementCtrl.text;
                setEngagement();

                final Database database = await openDatabase(
                    'engagements.db', version: 1, onCreate: (Database db, int version) async{
                  await db.execute(
                      'CREATE TABLE IF NOT EXISTS engagements(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, timeStamp TEXT NOT NULL, acres INTEGER NOT NULL, orders TEXT NOT NULL);'
                    );
                  }
                );
                await database.transaction((txn) async {
                  await txn.rawInsert('INSERT INTO engagements(name, timeStamp, acres, orders) VALUES(?, ?, ?, ?)',
                    [dto.name, dto.fireTimeStamp, dto.size, "[]"]
                  );
                });
                await database.close();
                //loadEngagements();
                Navigator.of(context).pop();
              },
            )
          ]
        );
      }
    );
  }

}
