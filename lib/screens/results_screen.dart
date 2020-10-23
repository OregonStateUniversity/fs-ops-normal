import 'package:flutter/material.dart';

var results = "Trunk:   1400ft   \nLat:        700ft   \nToy:       350ft   \n";

class NewResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Estimate Result'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(results,
                style: TextStyle(fontSize: 32),
            ),
          ]
        ),
      ),
    );
  }
}