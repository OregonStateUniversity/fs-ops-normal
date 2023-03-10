import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'modify_estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../utils/date_time_formatter.dart';

class NewEstimateScreen extends StatefulWidget {
  static const routeName = 'newEstimateScreen';
  static const title = "NewEstimateScreen";

  const NewEstimateScreen({super.key});

  @override
  createState() => _NewEstimateScreenState();
}

class _NewEstimateScreenState extends State<NewEstimateScreen> {
  var formKey = GlobalKey<FormState>();

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
          structuresField(),
          const Padding(padding: EdgeInsets.all(10)),
          newEstimateButton(engagement!),
        ],
      ),
    );
  }

  void createNewEstimate(int acres, int structures, Engagement? engagement) {
    var estimate = Estimate(
        acres: acres,
        structures: structures,
        timeStamp: DateTimeFormatter.format(DateTime.now()));

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ModifyEstimateScreen(
                estimate: estimate,
                engagement: engagement,
              )),
    );
  }

  void flashError() {
    context.showFlashDialog(
      title: const Text("Invalid Input"),
      content: const Text(
          "Please enter non-negative integers for Acreage and Structures."),
      negativeActionBuilder: (context, controller, setState) {
        return TextButton(
          onPressed: () {
            controller.dismiss();
          },
          child: const Text("Dismiss"),
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
