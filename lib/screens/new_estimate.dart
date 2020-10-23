import 'package:flutter/material.dart';

class NewEstimateScreen extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Estimate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter Acreage',
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter acreage';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric( vertical: 16.0),
              child: ElevatedButton(
                onPressed: (){
                  // do something here when clicked
                },
                child: Text('Calculate Estimate'),
              )
            )
          ],
        ),
      ),
    );
  }
}
