import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.all(8),
            itemCount: fires.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text('${fires[index]}'),
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
