import 'dart:ffi';

import 'package:flutter/material.dart';
import 'modify_estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../utils/date_time_formatter.dart';
import 'dart:math';

const List<String> fireType = <String>['Grass', 'Timber'];
const List<String> fireShape = [
  'assets/images/fireShape1.png',
  'assets/images/fireShape2.png',
  'assets/images/fireShape3.png',
  'assets/images/fireShape4.png',
  'assets/images/fireShape5.png',
  'assets/images/fireShape6.png'];
const Map<String, int> fireShapeMap = {
  'assets/images/fireShape1.png': 1,
  'assets/images/fireShape2.png': 2,
  'assets/images/fireShape3.png': 3,
  'assets/images/fireShape4.png': 4,
  'assets/images/fireShape5.png': 5,
  'assets/images/fireShape6.png': 6};

class NewEstimateScreen extends StatefulWidget {
  static const routeName = 'newEstimateScreen';
  static const title = "NewEstimateScreen";

  const NewEstimateScreen({super.key});

  @override
  createState() => _NewEstimateScreenState();
}

class _NewEstimateScreenState extends State<NewEstimateScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var fireShapeVal = null;
  var fireTypeVal = null;
  var firePerimeter = null;

  var imgs = null;

  var myControllerAcreage = TextEditingController(text: " ");
  var myControllerStructure = TextEditingController(text: " ");
  var myControllerPerimeter = TextEditingController(text: " ");

  static const bool _acreageInputIsValid = true;
  static const bool _structureInputIsValid = true;
  static const bool _perimeterInputIsValid = true;


  @override
  Widget build(BuildContext context) {
    final Engagement? engagement =
        ModalRoute.of(context)!.settings.arguments as Engagement?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Estimate Screen'),
      ),
      body: ListView(
        children: <Widget>[
          const Padding(padding: EdgeInsets.all(10)),
          // acres text box
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // text box for acreage
              Expanded(
                flex: 4,
                child: TextField(
                  controller: myControllerAcreage,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter Acreage',
                    errorText: _acreageInputIsValid ? null : 'error',
                    border: OutlineInputBorder())),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              const Expanded(
                child: Text('- OR -', textAlign: TextAlign.center,)
              ),
              const Padding(padding: EdgeInsets.all(10)),
              // button for acreage calculation popup
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  onPressed: () {
                    showInformationDialog(context);
                  },
                  child: const Text("Calculate Acerage", textAlign: TextAlign.center)
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
            ]
          ),
          const Padding(padding: EdgeInsets.all(10)),
          // structures text box
          TextField(
              controller: myControllerStructure,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Enter Structures',
                  errorText: _structureInputIsValid ? null : 'error',
                  border: OutlineInputBorder())),
          const Padding(padding: EdgeInsets.all(10)),
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
              child: const Text("Generate Estimate")),
        ],
      ),
    );
  }


  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        bool isChecked = false;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // enter perimeter of fire
                  // structures text box
                  TextField(
                    controller: myControllerPerimeter,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter Perimeter in Chains',
                      errorText: _structureInputIsValid ? null : 'error',
                      border: OutlineInputBorder()
                    )
                  ),
                  // select fire shape
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
                  ],
                )),
              title: const Text('Enter perimeter in chains and select rough shape.'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: () {
                    if (true) {
                      myControllerAcreage.text = calculateAcreage();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });

        
  }

  // calculates acreage of a fire given its shape and perimeter in chains
  String calculateAcreage() {
    int? fireShapeNum = fireShapeMap[fireShapeVal];
    int? perimeter = int.parse(myControllerPerimeter.text);
    double calcAcres = 0;
    switch(fireShapeNum) {
      /// CALCULATIONS BASED ON WILDLAND FIRE TABLE DATA POINTS
      /// INACCURATE FOR LOWER PERIMETER VALUES
      case 1:  // fire is a circle
        calcAcres = 0.007 * pow(perimeter, 2) - 0.0041 * perimeter;
        break;
      case 2:  // fire is tall rectangle
        calcAcres = 0.006 * pow(perimeter, 2) + 0.0034 * perimeter;
        break;
      case 3:  // shape is triangle or sideways rectangle
        calcAcres = 0.0049 * pow(perimeter, 2) + 0.0044 * perimeter;
        break;
      case 4:  // fire is close to square
        calcAcres = 0.004 * pow(perimeter, 2) + 0.0006 * perimeter;
        break;
      case 5:  // amoeba shape 1
        calcAcres = 0.003 * pow(perimeter, 2) + 0.0014 * perimeter;
        break;
      case 6:  // amoeba shape 2
        calcAcres = 0.0027 * pow(perimeter, 2) - 0.0319 * perimeter;
        break;
    }
    return calcAcres.toString();
  }
  
}
