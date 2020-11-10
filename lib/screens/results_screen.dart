import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'selected_engagement.dart';

class NewResultsScreen extends StatefulWidget{
  var acreage = '0';

  NewResultsScreen({this.acreage});

  @override
  _NewResultsScreenState createState() => _NewResultsScreenState();
}


class _NewResultsScreenState extends State<NewResultsScreen> {


  @override
  Widget build(BuildContext context) {

    var _trunkVal = 0;
    _trunkVal = (int.parse(widget.acreage)*400) + 1000;
    var _latVal = 0;
    _latVal = _trunkVal ~/ 2;
    var _toyVal = 0;
    _toyVal = _latVal ~/ 2;
    //var _results = "Trunk: ${_trunkVal.toInt()} ft\nLat: ${_latVal.toInt()} ft\nToy: ${_toyVal.toInt()} ft\n";

    final trunkCon = new TextEditingController();
    final latCon = new TextEditingController();
    final toyCon = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Estimate Result'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Your estimate order for ${widget.acreage} acres",
                  style: TextStyle(fontSize: 26),
                  textAlign: TextAlign.center,
                ),
              ),

              Text("Trunk Line Estimate"),
              buttonHelper(trunkCon, _trunkVal),

              Text("Lat Line Estimate"),
              buttonHelper(latCon, _latVal),

              Text("Toy Line Estimate"),
              buttonHelper(toyCon, _toyVal),

              OutlineButton(
                onPressed: () {
                  // finalize the order when pressed.
                  // pass data from fields to new widget that
                  // will save it somehow.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectedEngagement()
                    ),
                  );

                },
                child: Text("Finalize Order"),
              ),
          ]
        ),
      ),
    );
  }


  Widget buttonHelper(con, initVal){
    return NumberInputWithIncrementDecrement(
      controller: con,
      style: TextStyle(fontSize: 28),
      scaleHeight: .70,
      decIconSize: 40,
      incIconSize: 40,
      incDecFactor: 50,
      //buttonArrangement: ButtonArrangement.incRightDecLeft,
      initialValue: initVal,
    );
  }
}