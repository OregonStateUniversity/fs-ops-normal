import 'package:flutter/material.dart';
import 'package:hose_jockey/screens/engagement_screen.dart';
import 'package:hose_jockey/time_format.dart';
import 'modify_estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import 'engagement_screen.dart';
import 'main_screen.dart';

class CreateOrderScreen extends StatelessWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  static const routeName = 'createOrderScreen';
  static const title = "CreateOrderScreen";

  final bool _acreageInputIsValid = true;
  final bool _structureInputIsValid = true;
  //after we encapsulate into a different class, this will need to change from 'final'

  final _acreage = '5';
  final _structures = '5';
  //this will need to be changed from final as well

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Order Screen'),
        ),
        body: ListView(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(10)),
            TextField(
                controller: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Enter acreage',
                    errorText: _acreageInputIsValid ? null : 'error',
                    border: const OutlineInputBorder())),
            Padding(padding: const EdgeInsets.all(10)),
            TextField(
                controller: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Enter Structures',
                    errorText: _structureInputIsValid ? null : 'error',
                    border: const OutlineInputBorder())),
            OutlinedButton(
                onPressed: () {
                  var estimate = new Estimate(
                      acres: int.parse(_acreage),
                      //structures: int.parse(_structures),
                      //this is hardcoded to 5 until we encapsulate and can have non final variables
                      timeStamp: TimeFormat.currentTime);
                  estimate.initialLineCalculation();
                  _acreage.isNotEmpty
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ModifyEstimateScreen(
                                    estimate: estimate,
                                    // engagement: engagement,
                                  )),
                        )
                      : ArgumentError.notNull('Value Can\'t Be Empty');
                },
                child: Text("Create Order"))
          ],
        ));
  }
}
