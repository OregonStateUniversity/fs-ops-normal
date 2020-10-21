import 'package:flutter/material.dart';
import 'new_estimate.dart';

class MainScreen extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Estimate'),
          onPressed: (){
            // Navigate to other page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewEstimateScreen()),
            );
          },
        ),
      ),
    );
  }
}
