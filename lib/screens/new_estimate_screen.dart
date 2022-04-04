import 'package:flutter/material.dart';
import 'modify_estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../utils/time_format.dart';
import '../widgets/bottom_nav_bar.dart';

class NewEstimateScreen extends StatefulWidget {
  static const routeName = 'newEstimateScreen';
  static const title = "NewEstimateScreen";
  @override
  _NewEstimateScreenState createState() => _NewEstimateScreenState();
}

class _NewEstimateScreenState extends State<NewEstimateScreen> {
  var formKey = GlobalKey<FormState>();

  static var myControllerAcreage = TextEditingController(text: "0");
  static var myControllerStructure = TextEditingController(text: "0");

  static const bool _acreageInputIsValid = true;
  static const bool _structureInputIsValid = true;

  @override
  void disposeMyControllerAcreage() {
    // Clean up the controller when the widget is disposed.
    myControllerAcreage.dispose();
    super.dispose();
  }

  @override
  void disposeMyControllerStructure() {
    // Clean up the controller when the widget is disposed.
    myControllerStructure.dispose();
    super.dispose();
  }

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
          Padding(padding: const EdgeInsets.all(10)),
          TextField(
              controller: myControllerAcreage,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Enter Acreage',
                  errorText: _acreageInputIsValid ? null : 'error',
                  border: const OutlineInputBorder())),
          Padding(padding: const EdgeInsets.all(10)),
          TextField(
              controller: myControllerStructure,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Enter Structures',
                  errorText: _structureInputIsValid ? null : 'error',
                  border: const OutlineInputBorder())),
          OutlinedButton(
              onPressed: () {
                var estimate = new Estimate(
                    acres: int.parse(myControllerAcreage.text),
                    structures: int.parse(myControllerStructure.text),
                    timeStamp: TimeFormat.currentTime);
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
                myControllerStructure.text.isNotEmpty
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
              child: Text("New Estimate")),
        ],
      ),
      bottomNavigationBar: BottomNavBar(goBack: '/'),
    );
  }
}
