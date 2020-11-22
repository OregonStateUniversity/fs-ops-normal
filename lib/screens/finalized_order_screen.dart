import 'package:flutter/material.dart';

class FinalizedOrderScreen extends StatelessWidget{

  FinalizedOrderScreen(this.data);
  final data;

  @override
  Widget build(BuildContext context) {

     return Scaffold(
       appBar: AppBar(
         title: Text("Copy Your Order"),
       ),
       body: Column(
         children: [
           SelectableText(
               "Trunk Line: ${data.trunkLineLength} ft\n"
               "Lat Line: ${data.latLineLength} ft\n"
                   "ToyLine: ${data.toyLineLength} ft\n"),
         ],
       ),
     );
  }
}