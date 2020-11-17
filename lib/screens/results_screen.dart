import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'selected_engagement.dart';
import 'finalized_order.dart';

class NewResultsScreen extends StatefulWidget{
  
  static const routeName = 'newResults';
  var acreage;

  NewResultsScreen({this.acreage});

  @override
  _NewResultsScreenState createState() => _NewResultsScreenState();
}

class _NewResultsScreenState extends State<NewResultsScreen> {

  @override
  Widget build(BuildContext context) {
    var copyVal = '';
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

              buttonHelper(_trunkVal, trunkCon, 100, "Trunk Line"),

              buttonHelper(_latVal, latCon, 100, "Lat Line"),

              buttonHelper(_toyVal, toyCon, 50, "Toy Line"),

              OutlineButton(
                onPressed: () {
                  copyVal = "Trunk Line: " + trunkCon.text + "\n" + "Lat Line: " + latCon.text + "\n" + "Toy Line: " + toyCon.text;
                  // finalize the order when pressed.
                  // pass data from fields to new widget that
                  // will save it somehow.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FinalizedOrder(copyVal)
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


  Widget buttonHelper(val, con, inc, name){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Text(
                    '$name',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 5,
                child: Column(
                  children: <Widget> [
                    NumberInputWithIncrementDecrement(
                      controller: con,
                      style: TextStyle(fontSize: 28),
                      decIconSize: 30,
                      incIconSize: 30,
                      incDecFactor: inc,
                      initialValue: val,
                      scaleHeight: .90,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}