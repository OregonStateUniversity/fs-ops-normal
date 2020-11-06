import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hose_jockey/screens/selected_engagement.dart';
import 'create_new_engagement_screen.dart';
//import 'results_screen.dart';

class Fire{
  String name;
  int size;

  Fire(this.name, this.size);

  @override
  String toString() {
    return '{ ${this.name}, ${this.size} }';
  }
}

class MainScreen extends StatefulWidget{
  const MainScreen({Key key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List fires = [
    Fire('Alpha Fire', 500),
    Fire('Beta Fire', 1000),
    Fire('Gamma Fire', 575)
  ];

  // _MainScreenState({Key key, @required this.fires}) : super(key: key);

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

            itemCount: fires.length,
            itemBuilder: (context, index){
              //return Padding(
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectedEngagement()),
                  );
                },
                child: ListTile(
                  title: Text('${fires[index].name}'),
                  subtitle: Text('Current Size: ${fires[index].size}'),
                ),
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
              );
            },
          )
        ),
        

            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => SelectedEngagement()),
            //   );
            // },
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
