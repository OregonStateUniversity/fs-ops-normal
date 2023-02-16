import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'modify_estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../utils/date_time_formatter.dart';

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
                      TextFormField(
                        controller: myControllerPerimeter,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return value != "" ? null : "Enter Perimeter in Chains";
                        },
                        decoration:
                            const InputDecoration(hintText: "Please Enter Perimeter"),
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
              title: Text('Enter perimeter in chains and select rough shape.'),
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

  String calculateAcreage() {
    int? fireShapeNum = fireShapeMap[fireShapeVal];
    int? perimeter = int.parse(myControllerPerimeter.text);
    double calcAcres = 0;
    switch(fireShapeNum) {
      /// CALCULATIONS INCORRECT PLACEHOLDERS, NEED TO UPDATE
      case 1:  // fire is a circle
        calcAcres = perimeter * 0.7;
        break;
      case 2:  // fire is tall rectangle
        calcAcres = perimeter * 0.6;
        break;
      case 3:  // shape is triangle or sideways rectangle
        calcAcres = perimeter * 0.5;
        break;
      case 4:  // fire is close to square
        calcAcres = perimeter * 0.4;
        break;
      case 5:  // amoeba shape 1
        calcAcres = perimeter * 0.3;
        break;
      case 6:  // amoeba shape 2
        calcAcres = perimeter * 0.2;
        break;
    }
    return calcAcres.toString();
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
