import 'package:flutter/material.dart';


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
              Text('Trunk Hose:  \nToy Hose:   \nFittings: \n',
            ),
          ]
        ),
      ),
    );
  }
}