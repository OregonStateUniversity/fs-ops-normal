import 'package:flutter/material.dart';
import '../models/estimate.dart';

class EstimateScreen extends StatelessWidget{

  static const routeName = 'estimateScreen';

  @override
  Widget build(BuildContext context) {
    final Estimate estimate = ModalRoute.of(context).settings.arguments;
     return Scaffold(
       appBar: AppBar(
         title: Text("Copy Your Order"),
       ),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Padding(
                 padding: EdgeInsets.all(16),
                 child: SelectableText(
                     "Trunk Line: ${estimate.trunkLineLength} ft\n"
                         "Lat Line: ${estimate.latLineLength} ft\n"
                         "Toy Line: ${estimate.toyLineLength} ft\n"
                         "Acre: ${estimate.acres}\n"
                 ),
               ),
             ],
           ),

            Align(
              alignment: Alignment.bottomCenter,
              child:
                RaisedButton(
                  onPressed: (){
                    Navigator.popUntil(context, ModalRoute.withName('engagement'));
                  },
                  child: Text("Back"),
                )
            )
         ],
       ),
     );
  }
}