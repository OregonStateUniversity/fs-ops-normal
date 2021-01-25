import 'package:flutter/material.dart';
import '../models/estimate.dart';

class EstimateScreen extends StatelessWidget{

  static const routeName = 'estimateScreen';

  @override
  Widget build(BuildContext context) {
    final Estimate estimate = ModalRoute.of(context).settings.arguments;
     return Scaffold(
       appBar: AppBar(
         automaticallyImplyLeading: false,
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
                 ),
               ),
             ],
           ),
         ],
       ),
       bottomNavigationBar: BottomAppBar(
         child: new Row(
           mainAxisSize: MainAxisSize.max,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             IconButton(icon: Icon(Icons.home), onPressed: (){Navigator.popUntil(context, ModalRoute.withName('/'));},),
             FlatButton(
               onPressed: (){
                 Navigator.popUntil(context, ModalRoute.withName('engagement'));
               },
               child: Text("Back"),
             )
           ],
         ),
       ),
     );

  }
}