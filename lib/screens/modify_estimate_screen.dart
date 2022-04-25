import 'package:flutter/material.dart';
import 'estimate_screen.dart';
import 'engagement_list_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../persistence/database_helper.dart';

class OrderFields {
  int? acres;
  int? trunkLineLength;
  int? latLineLength;
  int? toyLineLength;
  int? fittingsField;
}

class ModifyEstimateScreen extends StatefulWidget {
  static const routeName = 'modifyEstimateScreen';

  final Estimate? estimate;
  final Engagement? engagement;
  ModifyEstimateScreen({this.estimate, this.engagement});

  @override
  _ModifyEstimateScreenState createState() => _ModifyEstimateScreenState();
}

class _ModifyEstimateScreenState extends State<ModifyEstimateScreen> {
  int _selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  OrderFields orderField = new OrderFields();
  Estimate? est;

  void _onItemTapped(int index) {
    Navigator.pushNamed(context, EngagementListScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    orderField.acres = widget.estimate?.acres;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Estimate Result'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
          child: Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  trunkLineRow(),
                  const SizedBox(height: 24.0),
                  latLineRow(),
                  const SizedBox(height: 24.0),
                  toyLineRow(),
                  const SizedBox(height: 24.0),
                  fittingsRow(),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        // var newNum = checkNamingNumber();
                        var newNum = 0;
                        var finalEstimate = new Estimate.finalEstimate(
                            newNum,
                            orderField.acres,
                            widget.estimate?.timeStamp,
                            widget.estimate?.structures,
                            orderField.trunkLineLength,
                            orderField.latLineLength,
                            orderField.toyLineLength,
                            orderField.fittingsField);
                        DatabaseHelper.insertOrder(
                            widget.engagement, finalEstimate);
                        Navigator.pushNamed(context, EstimateScreen.routeName,
                            arguments: finalEstimate);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    ),
                    child: Text('Save',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  )
                ]),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavBar(goBack: '/'),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: (Colors.blueGrey[900]!),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: (Colors.blueGrey[900]!),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget trunkLineRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.trunkLineLength.toString(),
            style: TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Trunk Line',
              suffixText: 'ft.',
            ),
            onSaved: (value) {
              orderField.trunkLineLength = int.parse(value!);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Needs some value";
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget latLineRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.latLineLength.toString(),
            style: TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Lat Line',
              suffixText: 'ft.',
            ),
            onChanged: (value) {
              orderField.fittingsField = int.parse(value) ~/ 100;
            },
            onSaved: (value) {
              orderField.latLineLength = int.parse(value!);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Needs some value";
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget toyLineRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.toyLineLength.toString(),
            style: TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Toy Line',
              suffixText: 'ft.',
            ),
            onSaved: (value) {
              orderField.toyLineLength = int.parse(value!);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Needs some value";
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget fittingsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.fittings.toString(),
            style: TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Various Fittings',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.fittingsField = int.parse(value!);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Needs some value";
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }
}
