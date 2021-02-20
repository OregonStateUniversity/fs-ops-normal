import 'package:flutter/material.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import 'estimate_screen.dart';
import 'package:hose_jockey/database_helper.dart';

class OrderFields{
  int acres;
  int trunkLineLength;
  int latLineLength;
  int toyLineLength;
  int fittingsField;
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
      resizeToAvoidBottomInset: false,
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
              fittingsRow(),

              RaisedButton(
                onPressed: (){
                  if (formKey.currentState.validate()){
                    formKey.currentState.save();
                    var finalEstimate = new Estimate.loadSavedEstimate("NoNameNeeded", orderField.acres, widget.estimate.timeStamp, orderField.trunkLineLength, orderField.latLineLength, orderField.toyLineLength, orderField.fittingsField);
                    DatabaseHelper.insertOrder(widget.engagement, finalEstimate);
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
        Text("ft."),
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
            onChanged: (value) {
              orderField.fittingsField = int.parse(value) ~/ 100;
            },
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
        Text("ft."),
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
        Text("ft."),
      ],
    );
  }

  Widget fittingsRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            "Various Fittings",
            style: TextStyle(fontSize: 24),
          ),
        ),
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate.fittings.toString(),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onSaved: (value){
              orderField.fittingsField = int.parse(value);
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
        Text("ea."),
      ],
    );
  }
}