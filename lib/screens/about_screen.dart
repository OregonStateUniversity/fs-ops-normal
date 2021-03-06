import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget{
  static const routeName = 'about';
  static const title = "About";
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
              child: Column(
                children: [
                  Text("Created By Josh C. and Kyle H. for"),
                  Text("OSU-Cascades Computer Science Final Project"),
                  Divider(),
                  Text("Ops Normal is an application designed for wild land firefighters to \n"
                      "quickly estimate the amount of equipment that they will need to fight a fire.\n"
                      ""),
                  Divider(),
                  Text("The source code for this project can be found at https://github.com/osu-cascades/fs-hose-jockey")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}