import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget{
  static const routeName = 'about';
  static const title = "About";

  static const TextAlign align = TextAlign.center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Align(
            alignment: FractionalOffset.center,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("Created By Josh C. and Kyle H. for", textAlign: align,),
                  Text("OSU-Cascades Computer Science Final Project", textAlign: align,),
                  Divider(),
                  Text("Ops Normal is an application designed for wild land firefighters to "
                      "quickly estimate the amount of equipment that they will need to fight a fire", textAlign: align,),
                  Divider(),
                  Text("The source code for this project can be found at https://github.com/osu-cascades/fs-hose-jockey", textAlign: align,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}