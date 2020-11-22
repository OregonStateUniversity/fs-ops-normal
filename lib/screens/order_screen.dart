import 'package:flutter/material.dart';
import '../models/estimate.dart';
import 'selected_engagement_screen.dart';
import 'finalized_order_screen.dart';

class OrderFields{
  String trunkLength;
  String latLength;
  String toyLength;
}


class NewResultsScreen extends StatefulWidget{
  
  static const routeName = 'newResults';

  final Estimate estimate;

  NewResultsScreen({this.estimate});

  @override
  _NewResultsScreenState createState() => _NewResultsScreenState();
}

class _NewResultsScreenState extends State<NewResultsScreen> {

  var formKey = GlobalKey<FormState>();
  final orderEntryField = OrderFields();

  @override
  Widget build(BuildContext context) {

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
                    // save to db here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FinalizedOrderScreen(orderEntryField))
                    );
                  }
                },
                child: Text("Copy and Save"),
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
              orderEntryField.trunkLength = value;
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
              orderEntryField.latLength = value;
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
              orderEntryField.toyLength = value;
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

}