import 'package:flutter/material.dart';


class NewResultsScreen extends StatelessWidget {

  final acreage;
  NewResultsScreen({this.acreage});


  @override
  Widget build(BuildContext context) {
    var trunkVal = (int.parse(acreage)*400) + 1000;
    var latVal = trunkVal / 2;
    var toyVal = latVal / 2;
    var results = "Trunk: ${trunkVal.toInt()} ft\nLat: ${latVal.toInt()} ft\nToy: ${toyVal.toInt()} ft\n";
    return Scaffold(
        appBar: AppBar(
          title: Text('Estimate Result'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Your estimate order for $acreage acres",
                style: TextStyle(fontSize: 26),
                textAlign: TextAlign.center,
              ),
              Text(
                results,
                style: TextStyle(fontSize: 32),
                  textAlign: TextAlign.center
            ),
          ]
        ),
      ),
    );
  }
}