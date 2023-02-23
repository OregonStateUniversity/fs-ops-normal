import 'dart:io';

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

  //final _selectedIndex = 0;

  /*void _onItemTapped(int index) {
    Navigator.pushNamed(context, ActiveEngagementListScreen.routeName);
  }*/

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
          TextField(
              controller: myControllerAcreage,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              decoration: const InputDecoration(
                  labelText: 'Enter Acreage',
                  errorText: _acreageInputIsValid ? null : 'error',
                  border: OutlineInputBorder())),
          const Padding(padding: EdgeInsets.all(10)),
          TextField(
              controller: myControllerStructure,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              decoration: const InputDecoration(
                  labelText: 'Enter Structures',
                  errorText: _structureInputIsValid ? null : 'error',
                  border: OutlineInputBorder())),
          OutlinedButton(
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
              child: const Text("New Estimate")),
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
      title: const Text("Invalid input"),
      content: const Text(
          "Please enter non-negative integers for Acreage and Structures."),
      negativeActionBuilder: (context, controller, setState) {
        return TextButton(
          onPressed: () {
            controller.dismiss();
          },
          child: const Text("dismiss"),
        );
      },
    );
  }
}
