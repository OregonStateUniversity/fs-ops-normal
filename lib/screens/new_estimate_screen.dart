import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'modify_estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../utils/date_time_formatter.dart';

//const List<String> fireShape = <String>['Shape 1', 'Shape 2', 'Shape 3'];
const List<String> fireType = <String>['Grass', 'Timber'];
const List<String> fireShape = <String>['assets/images/fireShape1.png',
'assets/images/fireShape2.png',
'assets/images/fireShape3.png',
'assets/images/fireShape4.png',
'assets/images/fireShape5.png',
'assets/images/fireShape6.png'];

class NewEstimateScreen extends StatefulWidget {
  static const routeName = 'newEstimateScreen';
  static const title = "NewEstimateScreen";

  const NewEstimateScreen({super.key});

  @override
  createState() => _NewEstimateScreenState();
}

class _NewEstimateScreenState extends State<NewEstimateScreen> {
  var formKey = GlobalKey<FormState>();

  var fireShapeVal = null;
  var fireTypeVal = null;
  var firePerimeter = null;

  var myControllerAcreage = TextEditingController(text: "");
  var myControllerStructure = TextEditingController(text: "");

  static const bool _acreageInputIsValid = true;
  static const bool _structureInputIsValid = true;

  @override
  Widget build(BuildContext context) {
    final Engagement? engagement =
        ModalRoute.of(context)!.settings.arguments as Engagement?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Estimate Screen'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          const Padding(padding: EdgeInsets.all(10)),
          acreageField(),
          const Padding(padding: EdgeInsets.all(10)),
          // button for acre calculation popup
          const Text('--OR--'),
          OutlinedButton(
              onPressed: () {
                _dialogBuilder(context);
              },
              child: const Text("Calculate Acerage")),
          const Padding(padding: EdgeInsets.all(10)),
          structuresField(),
          const Padding(padding: EdgeInsets.all(10)),
          // fire type dropdown
          /*DropdownButton<String>(
            hint: const Text('Select Fuel Type'),
            value: fireTypeVal,
            icon: const Icon(Icons.arrow_drop_down),
            isExpanded: true, 
            onChanged: (String? value) {  // user selected an item
              setState(() {
                fireTypeVal = value!;
                });
            },
            // entries in the dropdown
            items: fireType.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),),
          const Padding(padding: EdgeInsets.all(10)),
          // fire shape dropdown
          DropdownButton<String>(
            hint: const Text('Select Fire Shape'),
            value: fireShapeVal,
            icon: const Icon(Icons.arrow_drop_down),
            isExpanded: true,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                fireShapeVal = value!;
                });
            },
            // entries in the dropdown
            items: fireShape.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Image.asset(value)
              );
            }).toList(),),
          const Padding(padding: EdgeInsets.all(10)),*/
          // button to generate estimate
          OutlinedButton(
              onPressed: () {
                var acreseDouble = double.parse(myControllerAcreage.text);
                var estimate = Estimate(
                    acres: acreseDouble.toInt(),
                    structures: int.parse(myControllerStructure.text),
                    timeStamp: DateTimeFormatter.format(DateTime.now()));
                myControllerAcreage.text.isNotEmpty
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModifyEstimateScreen(
                                  estimate: estimate,
                                  engagement: engagement,
                                )),
                      )
                    : ArgumentError.notNull('Value Can\'t Be Empty');
              },
              child: const Text("New Estimate")),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fire Parameters'),
          content: const Text('Enter the perimeter in chains (1 chain = 66ft) and select the rough shape to caclulate the acreage.'),
          actions: <Widget>[

            // text box to enter fire perimeter in chains
            TextField(
              controller: myControllerAcreage,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Enter Perimeter (in chains)',
                  errorText: _acreageInputIsValid ? null : 'error',
                  border: OutlineInputBorder())),
            const Padding(padding: EdgeInsets.all(10)),

            // dropdown to select fire shape
            DropdownButton<String>(
            hint: const Text('Select Fire Shape'),
            value: fireShapeVal,
            icon: const Icon(Icons.arrow_drop_down),
            isExpanded: true,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                fireShapeVal = value;
              });
            },
            // entries in the dropdown
            items: fireShape.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Image.asset(value)
              );
            }).toList(),),

            // button to generate acreage
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Calculate Acreage'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  

  Widget acreageField() {
    return TextField(
        controller: myControllerAcreage,
        keyboardType: const TextInputType.numberWithOptions(
            signed: false, decimal: false),
        decoration: const InputDecoration(
            labelText: 'Enter Acreage',
            errorText: _acreageInputIsValid ? null : 'error',
            border: OutlineInputBorder()));
  }

  Widget structuresField() {
    return TextField(
        controller: myControllerStructure,
        keyboardType: const TextInputType.numberWithOptions(
            signed: false, decimal: false),
        decoration: const InputDecoration(
            labelText: 'Enter Structures',
            errorText: _structureInputIsValid ? null : 'error',
            border: OutlineInputBorder()));
  }

  Widget newEstimateButton(Engagement engagement) {
    return FloatingActionButton.extended(
        onPressed: () {
          int acres = 0;
          int structures = 0;
          bool validInput = true;

          try {
            acres = int.parse(myControllerAcreage.text);
            structures = int.parse(myControllerStructure.text);

            if (acres < 1 || structures < 0) {
              throw (1);
            }
          } catch (e) {
            validInput = false;
          }

          if (validInput) {
            createNewEstimate(acres, structures, engagement);
          } else {
            flashError();
            myControllerAcreage.clear();
            myControllerStructure.clear();
          }
        },
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add),
        label: const Text("New Estimate"));
  }
}
