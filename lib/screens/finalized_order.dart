import 'package:flutter/material.dart';

class FinalizedOrder extends StatelessWidget{

  FinalizedOrder(this.data);
  final data;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Scaffold(
       appBar: AppBar(
         title: Text("Copy Your Order"),
       ),
       body: Column(
         children: [
           Text("$data")
         ],
       ),
     );
  }
}