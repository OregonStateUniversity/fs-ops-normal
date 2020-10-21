import 'package:flutter/material.dart';
import 'package:hose_jockey/screens/main_screen.dart';
import 'package:hose_jockey/screens/new_estimate.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hose Jockey',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen()
    );
  }
}
