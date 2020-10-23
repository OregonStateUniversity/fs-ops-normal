import 'package:flutter/material.dart';
import 'new_estimate.dart';
import 'results_screen.dart';

class MainScreen extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            GestureDetector (
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewResultsScreen()),
                );
              },
              child: Container(
                height: 50,
                color: Colors.blue[300],
                child: const Center(child: Text('Entry A')),
              ),
  
            ),
            
          ],
        ),
      ),
        
      floatingActionButton: FloatingActionButton(	
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewEstimateScreen()),
          );
        },	
        tooltip: 'New estimate',	
        child: Icon(Icons.add),	
      )
    );
  }
}
