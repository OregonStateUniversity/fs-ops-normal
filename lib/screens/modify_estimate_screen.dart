import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import 'engagement_screen.dart';
import 'estimate_screen.dart';
import 'package:hose_jockey/time_format.dart';

class OrderFields{
  int acres;
  int trunkLineLength;
  int latLineLength;
  int toyLineLength;
}


class ModifyEstimateScreen extends StatefulWidget{
  
  static const routeName = 'modifyEstimateScreen';

  final Estimate estimate;
  final Engagement engagement;
  ModifyEstimateScreen({this.estimate, this.engagement});

  @override
  _ModifyEstimateScreenState createState() => _ModifyEstimateScreenState();
}

class _ModifyEstimateScreenState extends State<ModifyEstimateScreen> {
  var formKey = GlobalKey<FormState>();
  OrderFields orderField = new OrderFields();

  Estimate est;
  @override
  Widget build(BuildContext context) {

    orderField.acres = widget.estimate.acres;
    return Scaffold(
      appBar: AppBar(
        title: Text('Estimate Result'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              trunkLineRow(),
              latLineRow(),
              toyLineRow(),

              RaisedButton(
                onPressed: (){
                  if (formKey.currentState.validate()){
                    formKey.currentState.save();
                    var finalEstimate = new Estimate.loadSavedEstimate("NoNameNeeded", orderField.acres, widget.estimate.timeStamp, orderField.trunkLineLength, orderField.latLineLength, orderField.toyLineLength);
                    addNewEstimate(widget.engagement, finalEstimate);
                    Navigator.pushNamed(context, EstimateScreen.routeName, arguments: finalEstimate);
                  }
                },
                child: Text("Save"),
              )
          ]
        ),
      ),
    ));
  }

  Widget trunkLineRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            "Trunk Line",
            style: TextStyle(fontSize: 24),
          ),
        ),
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate.trunkLineLength.toString(),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onSaved: (value){
              orderField.trunkLineLength = int.parse(value);
            },
            validator: (value){
              if(value.isEmpty){
                return "Needs some value";
              } else{
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget latLineRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            "Lat Line",
            style: TextStyle(fontSize: 24),
          ),
        ),
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate.latLineLength.toString(),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onSaved: (value){
              orderField.latLineLength = int.parse(value);
            },
            validator: (value){
              if(value.isEmpty){
                return "Needs some value";
              } else{
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget toyLineRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            "Toy Line",
            style: TextStyle(fontSize: 24),
          ),
        ),
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate.toyLineLength.toString(),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onSaved: (value){
              orderField.toyLineLength = int.parse(value);
            },
            validator: (value){
              if(value.isEmpty){
                return "Needs some value";
              } else{
                return null;
              }
            },
          ),
        ),
      ],
    );
  }


  void addNewEstimate(engage, order) async{
    final Database database = await openDatabase(
        'engagements.db', version: 1, onCreate: (Database db, int version) async{
      await db.execute(
          'CREATE TABLE IF NOT EXISTS engagements(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, timeStamp TEXT NOT NULL, acres INTEGER NOT NULL, orders TEXT NOT NULL);'
      );
    });
    engage.orders.add(order);
    await database.transaction((txn) async {
      String tmp = "'[";
      engage.orders.forEach((value) {
        tmp += json.encode(value.toJson());
        if((engage.orders.last != value)){
          tmp += ", ";
        }
      });
      tmp += "]'";
      await txn.rawUpdate('UPDATE engagements SET orders = $tmp WHERE id = ${engage.primaryKey}',
      );
    });
    await database.close();
  }
}