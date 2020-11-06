import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hose_jockey/screens/selected_engagement.dart';
import 'create_new_engagement_screen.dart';
//import 'results_screen.dart';

class Fire{
  String name;
  String fireTimeStamp;
  int size;


  Fire(this.name, this.fireTimeStamp, this.size);

  @override
  String toString() {
    return '{ ${this.name}, ${this.fireTimeStamp}, ${this.size} }';
  }
}

class MainScreen extends StatefulWidget{
  const MainScreen({Key key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List fires = [
    Fire('Gamma Fire', '10-23-20', 500),
    Fire('Beta Fire', '7-4-20', 1000),
    Fire('Alpha Fire', '5-16-20', 575)
  ];

/////////////////////////////////////////////////////////////////////
  
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

/////////////////////////////////////////////////////////////////////////

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
            itemCount: fires.length,
            itemBuilder: (context, index){

              return ListTile(
                  title: Text('${fires[index].name}'),
                  subtitle: Text('Created: ${fires[index].fireTimeStamp}    Acreage: ${fires[index].size}'),

                /////3-dot button menu/////////////////////////////////////////////
                  trailing: PopupMenuButton<String>(
                    onSelected: (String newVal) {
                      _popBtnSelectVal = newVal;
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_popBtnSelectVal),
                        ),
                      );
                    },
                    itemBuilder: (BuildContext context) => _popUpMenuItems,
                  ),
                ////////////////////////////////////////////////////////////////////

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectedEngagement()),
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





                // padding: const EdgeInsets.all(8),
                // child: Card(
                //   elevation: 5.0,
                //   color: Colors.blue[100],
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(5.0)
                //   ),
                  
                  //margin: EdgeInsets.fromLTRB(2, 1, 2, 0),
                  // child: Container(
                  //   child: ListView.builder(
                  //     //padding: EdgeInsets.only(left: 8),
                  //     itemCount: fires.length,
                  //     itemBuilder: (BuildContext context, index) {
                  //       return GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(builder: (context) => SelectedEngagement()),
                  //           );
                  //         },
                  //         child: ListTile(
                  //           title: Text('${fires[index].name}'),
                  //           subtitle: Text('${fires[index].size}'),
                  //         )
                  //       );
                  //     }
                  //   )
                  // ),
                //),