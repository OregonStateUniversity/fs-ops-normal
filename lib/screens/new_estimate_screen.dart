import 'package:flutter/material.dart';
import 'package:hose_jockey/time_format.dart';
import 'modify_estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';

class NewEstimateScreen extends StatefulWidget {
  static const routeName = 'newEstimate';

  _NewEstimateScreenState createState() => _NewEstimateScreenState();
}

class _NewEstimateScreenState extends State<NewEstimateScreen> {
  var _acreage = '0';
  bool _validate = false;
  final acreageCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Engagement? engagement =
        ModalRoute.of(context)!.settings.arguments as Engagement?;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('New Estimate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter Acreage'),
            TextField(
              autofocus: true,
              controller: acreageCon,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                hintText: 'Acreage',
              ),
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  acreageCon.text.isEmpty
                      ? _validate = true
                      : _validate = false;
                  _acreage = acreageCon.text;
                });

                var estimate = new Estimate(
                    acres: int.parse(_acreage),
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
              child: Text('Calculate Estimate'),
            ),
          ],
        ),
      ),
    );
  }
}
