import 'package:flash/flash.dart';
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

<<<<<<< HEAD
  var myControllerAcreage = TextEditingController(text: "");
  var myControllerStructure = TextEditingController(text: "");
=======
  var imgs = null;

  var myControllerAcreage = TextEditingController(text: " ");
  var myControllerStructure = TextEditingController(text: " ");
  var myControllerPerimeter = TextEditingController(text: " ");
>>>>>>> 847fd18 (Resolving conflicts)

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
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          const Padding(padding: EdgeInsets.all(10)),
          acreageField(),
          const Padding(padding: EdgeInsets.all(10)),
          // button for acre calculation popup
          const Text('--OR--'),
          OutlinedButton(
              onPressed: () {
                showInformationDialog(context);
              },
              child: const Text("Calculate Acerage")),
          const Padding(padding: EdgeInsets.all(10)),
          // Structures input
          TextField(
              controller: myControllerStructure,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Enter Structures',
                  errorText: _structureInputIsValid ? null : 'error',
                  border: OutlineInputBorder())),
          // Fire Shape dropdown
          const Padding(padding: EdgeInsets.all(10)),
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
          const Padding(padding: EdgeInsets.all(10)),
          // Button to generate estimate
          OutlinedButton(
              onPressed: () {
                var acreseDouble = double.parse(myControllerAcreage.text);
                var estimate = Estimate(
                  perimeter: calculatePerimeter(),
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

  // calculates acreage of a fire given its shape and perimeter in chains
  int calculatePerimeter() {
    int? fireShapeNum = fireShapeMap[fireShapeVal];
    int? acresInput = int.parse(myControllerAcreage.text);
    double calcPerimeter = 0;
    switch(fireShapeNum) {
      /// CALCULATIONS BASED ON WILDLAND FIRE TABLE DATA POINTS
      /// INACCURATE FOR LOWER PERIMETER VALUES
      case 1:  // fire is a circle
        calcPerimeter = 780.48 * pow(acresInput, 0.5061);
        break;
      case 2:  // fire is tall rectangle
        calcPerimeter = 845.16 * pow(acresInput, 0.5045);
        break;
      case 3:  // shape is triangle or sideways rectangle
        calcPerimeter = 920.6 * pow(acresInput, 0.5089);
        break;
      case 4:  // fire is close to square
        calcPerimeter = 1017.4 * pow(acresInput, 0.5185);
        break;
      case 5:  // amoeba shape 1
        calcPerimeter = 1185.8 * pow(acresInput, 0.5171);
        break;
      case 6:  // amoeba shape 2
        calcPerimeter = 1433.7 * pow(acresInput, 0.5215);
        break;
    }
    return calcPerimeter.round();
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
