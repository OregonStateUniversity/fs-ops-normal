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

  final myControllerAcreage = TextEditingController();
  final myControllerStructure = TextEditingController();

  final bool _acreageInputIsValid = true;
  final bool _structureInputIsValid = true;

  final _acreage = '5';
  final _structures = '5';
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
                  labelText: 'Enter acreage',
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
                    acres: int.parse(_acreage),
                    structures: int.parse(_structures),
                    timeStamp: TimeFormat.currentTime);
                estimate.initialLineCalculation();

                _acreage.isNotEmpty
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
