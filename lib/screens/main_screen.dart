import 'package:flutter/material.dart';
import 'new_estimate.dart';

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
            Container(
              height: 50,
              color: Colors.blue[300],
              child: const Center(child: Text('Fire 1')),
            ),
            Container(
              height: 50,
              color: Colors.blue[100],
              child: const Center(child: Text('Fire 2')),
            ),
            Container(
              height: 50,
              color: Colors.blue[300],
              child: const Center(child: Text('Fire 3')),
            ),
            Container(
              height: 50,
              color: Colors.blue[100],
              child: const Center(child: Text('Fire 4')),
            ),
            Container(
              height: 50,
              color: Colors.blue[300],
              child: const Center(child: Text('Fire 5')),
            ),
            Container(
              height: 50,
              color: Colors.blue[100],
              child: const Center(child: Text('Fire 6')),
            ),
            Container(
              height: 50,
              color: Colors.blue[300],
              child: const Center(child: Text('Fire 7')),
            ),
            Container(
              height: 50,
              color: Colors.blue[100],
              child: const Center(child: Text('Fire 8')),
            ),
            Container(
              height: 50,
              color: Colors.blue[300],
              child: const Center(child: Text('Fire 9')),
            ),
            Container(
              height: 50,
              color: Colors.blue[100],
              child: const Center(child: Text('Fire 10')),
            ),
            Container(
              height: 50,
              color: Colors.blue[300],
              child: const Center(child: Text('Fire 11')),
            ),
            Container(
              height: 50,
              color: Colors.blue[100],
              child: const Center(child: Text('Fire 12')),
            ),
            Container(
              height: 50,
              color: Colors.blue[300],
              child: const Center(child: Text('Fire 13')),
            ),
            Container(
              height: 50,
              color: Colors.blue[100],
              child: const Center(child: Text('Fire 14')),
            ),
            Container(
              height: 50,
              color: Colors.blue[300],
              child: const Center(child: Text('Fire 15')),
            ),
            Container(
              height: 50,
              color: Colors.blue[100],
              child: const Center(child: Text('Fire 16')),
            ),
          ],
        ),
      ),
        
      
      // body: Center(
      //   child: ElevatedButton(
      //     child: Text('Estimate'),
      //     onPressed: (){
      //       // Navigate to other page
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => NewEstimateScreen()),
      //       );
      //     },
      //   ),
      // ),
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
