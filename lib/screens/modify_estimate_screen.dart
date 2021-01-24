import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import 'engagement_screen.dart';
import 'estimate_screen.dart';
import 'package:hose_jockey/time_format.dart';

class OrderFields{
  String trunkLineLength;
  String latLineLength;
  String toyLineLength;
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
  //final orderEntryField = OrderFields();
  Estimate est;
  @override
  Widget build(BuildContext context) {
    print("${widget.estimate} from modify_estimate_screen");
    print("${widget.engagement} from modify_estimate_screen");
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
                  print("${widget.estimate} = widget.estimate");
                  print("${widget.engagement} = widget.engagement");
                  if (formKey.currentState.validate()){
                    formKey.currentState.save();
                    print('${widget.estimate}');
                    // save to db here
                    print("passed into addNewEstimate\nEngagement: ${widget.engagement}\n Estimate:${widget.estimate}");
                    addNewEstimate(widget.engagement, widget.estimate);
                    Navigator.pushNamed(context, EstimateScreen.routeName, arguments: widget.estimate);
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
              print('before set: ${widget.estimate.trunkLineLength} => $value');
              widget.estimate.trunkLineLength = int.parse(value);
              print('after set:  ${widget.estimate.trunkLineLength} => $value');
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
              widget.estimate.latLineLength = int.parse(value);
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
              widget.estimate.toyLineLength = int.parse(value);
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
    }
    );

    print("$engage --------> engagement");
    print("${engage.orders} ======= engage.orders");
    print("$order  --------> order");

    //List<Estimate> tmpList = jsonDecOrder(engage.orders);
    engage.orders.add(order);
    print("${engage.orders} list of orders ---------------------------------");
    await database.transaction((txn) async {
      print("${engage.orders.toString()} HERE");
      print(engage.orders);
      String tmp = "'[";
      engage.orders.forEach((value) {
        print(value.toJson());
        tmp += json.encode(value.toJson());
        if((engage.orders.last != value)){
          tmp += ", ";
        }

        print(tmp);
      });
      tmp += "]'";
      print(tmp);
      await txn.rawUpdate('UPDATE engagements SET orders = $tmp WHERE id = ${engage.primaryKey}',
      );
    });
    print("$order updated DB");
    await database.close();
  }

  List<Estimate> jsonDecOrder(json){
    print("${json.runtimeType} ---------- JSON");
    if(json == null){
      return new List<Estimate>();
    }
    Iterable i = json.decode(json);
    List<Estimate> orderList = List<Estimate>.from(i.map((model) => Estimate.fromJson(model)));
    print("$orderList: jsonDecOrder list, decoded");
    return orderList;
  }
}