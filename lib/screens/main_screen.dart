import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hose_jockey/time_format.dart';
import 'dart:convert';
import 'engagement_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import 'package:hose_jockey/database_helper.dart';


class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);
  static const routeName = '/';

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {

  final engagementCtrl = new TextEditingController();
  final acreageCtrl = TextEditingController();
  final GlobalKey<MainScreenState> _key = GlobalKey();
  List<Engagement> engagements = [];

  var newName;
  var active = true; // always starts on active orders
  var engagementOrder = 0;

  void initState(){
    super.initState();
    loadEngagements();
  }

  var dto;

  void loadEngagements() async{
    List<Map> engagementRecords = await DatabaseHelper.getAllEngagements();
    if (engagementRecords != null) {
      final engagementEntries = engagementRecords.map((record) {
        print("active: ${record['active']}");
        return Engagement(
          record['name'],
          record['timeStamp'],
          record['acres'],
          loadOrders(record['orders']),
          record['active'],
          record['id'],
        );
      }).toList();
      setState(() {
        active == true ? 
        engagements = engagementEntries.reversed.toList().where((a) 
          => a.active == 1).toList() : 
        engagements = engagementEntries.reversed.toList().where((a) 
          => a.active == 0).toList();
      });
    } else{
      engagements = new List<Engagement>();
    }
  }

  List<Estimate> loadOrders(string) {
    Iterable i = json.decode(string);
    List<Estimate> orderEntries = List<Estimate>.from(i.map((model) 
      => Estimate.fromJson(model)));
    return orderEntries;
  }

  void setEngagement() {
    if (engagementCtrl.text.isNotEmpty) {
      setState(() {
            dto = Engagement( newName, timeFormat(), 250, [], 1);
      });
      engagementCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = active == true ? "Ops Normal" : "Ops Archive";
    if (engagements.isEmpty){
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.archive_outlined, 
              color: active == true ? Colors.white : Colors.yellow
            ),
            onPressed: () { 
              setState((){
                active == true ? 
                active = false : 
                active = true; }); 
              loadEngagements();
            },
          ),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                active == true ? 
                Text("No Engagements Created Yet") : 
                Text("No Engagements Archived Yet")
              ],
            ),
          ],
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: floatAccButton(),
        bottomNavigationBar: bottomNavBar()
      );

    } 
    else
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.archive_outlined, 
              color: active == true ? Colors.white : Colors.yellow
            ),
            onPressed: () { 
              setState((){
                active == true ? 
                active = false : 
                active = true; }); 
              loadEngagements();
            },
          ),
          actions: <Widget> [
            PopupMenuButton(
              icon: Transform.rotate(
                angle: 90*3.1415927/180,
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
              ],
              onSelected: (value) {
                if (value == 1) {
                  setState(() {
                    engagements.sort((a,b) 
                      => a.fireTimeStamp.compareTo(b.fireTimeStamp));
                  });
                }
                else if (value == 2) {
                  setState(() {
                    engagements.sort((a,b) 
                      => b.fireTimeStamp.compareTo(a.fireTimeStamp));
                  });
                }
              }
            ),
          ],
        ),

        body: Column(
          key: _key,
          children: <Widget> [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: engagements.length,
                itemBuilder: (context, index){
                  return Dismissible(
                    key: Key(engagements[index].primaryKey.toString()),
                    background: Stack(children: [
                      Container(
                        color: Colors.green,
                        child: Align(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                active == false ? Icons.unarchive_rounded : Icons.archive_rounded, 
                                color: Colors.white),
                              Text(
                                active == false ? "Unarchive" : "Archive", 
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontWeight: FontWeight.w700
                                )),
                              SizedBox(width: 20)
                            ],
                          ),
                        ),
                      ),
                    ],),
                    secondaryBackground: Stack(children: [
                      Container(
                        color: Colors.red,
                        child: Align(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.delete_forever_outlined, color: Colors.white),
                              Text(
                                "Delete", 
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontWeight: FontWeight.w700
                                )),
                              SizedBox(width: 20)
                            ],
                          ),
                        ),
                      ),
                    ],),
                    dismissThresholds: {
                      DismissDirection.startToEnd: 0.25,
                      DismissDirection.endToStart: 0.25
                    },
                    confirmDismiss: (DismissDirection direction) async{
                      if (direction == DismissDirection.endToStart) {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: const Text("Delete Engagement?"),
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
                      } 
                      else{
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: active == true ? 
                                     Text("Archive Engagement") : 
                                     Text("Unarchive Engagement"),
                              actions: [
                                FlatButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: active == true ? const Text("Archive") : Text("Unarchive"),
                                ),
                                FlatButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text("Cancel"),
                                )
                              ],
                            );
                          }
                        );
                      }
                    },
                    onDismissed: (direction){
                      if(direction == DismissDirection.endToStart){
                        DatabaseHelper.deleteEngagement(engagements[index].primaryKey);
                      } else if(active == true){
                        DatabaseHelper.archiveEngagement(engagements[index].primaryKey);
                      } else if(active == false){
                        DatabaseHelper.unarchiveEngagement(engagements[index].primaryKey);
                      }
                      loadEngagements();
                    },

                    child: ListTile(
                      title: Text('${engagements[index].name}', style: TextStyle(fontSize: 22),),
                      subtitle: Text('Created: ${engagements[index].fireTimeStamp}'),
                      onTap: () {
                        Navigator.pushNamed(
                          context, 
                          SelectedEngagement.routeName, 
                          arguments: engagements[index]
                        );
                      },
                    )
                  );
                }
              ),
            ),
          ]
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: floatAccButton(),
        bottomNavigationBar: bottomNavBar()
      );
  }

  _createEngagement(context) {
    return showDialog(
      context: context,
      builder: (context) {
        changeBackToActive();
        return AlertDialog(
          title: Text('Create New Engagement'),
          content: TextField(
            autofocus: true,
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
                engagementCtrl.clear();
                Navigator.of(context).pop();
              },
            ),
            OutlineButton(
              child: Text('Create'),
              onPressed: () async {
                newName = engagementCtrl.text;
                setEngagement();
                DatabaseHelper.insertEngagement(dto);
                loadEngagements();
                Navigator.of(context).pop();
              },
            ),
          ]
        );
      }
    );
  }

  Widget bottomNavBar(){
    return BottomAppBar(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(icon: Icon(Icons.home), 
          onPressed: (){},
          ),
        ],
      ),
    );
  }

  Widget floatAccButton(){
    return FloatingActionButton(
      onPressed: () => _createEngagement(context),
      tooltip: 'New estimate',
      child: Icon(Icons.add),
    );
  }

  void changeBackToActive(){
    active = true;
    loadEngagements();
  }
}
