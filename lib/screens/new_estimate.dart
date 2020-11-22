import 'package:flutter/material.dart';
import 'results_screen.dart';
import '../models/estimate.dart';

class NewEstimateScreen extends StatefulWidget{

  static const routeName = 'newEstimate';

  _NewEstimateScreenState createState() => _NewEstimateScreenState();
}

class _NewEstimateScreenState extends State<NewEstimateScreen> {

  var tmpEst = Estimate(name: "Test", acres: 10, timeStamp: DateTime.now().toString());


  var _acreage = '0';
  bool _validate = false;
  final acreageCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Estimate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter Acreage'),
            TextField(
              controller: acreageCon,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorText: _validate ? 'Value Can\'t Be Empty' : null,
                  hintText: 'Acreage',
              ),
            ),

            OutlineButton(
              onPressed: (){
                setState(() {
                  acreageCon.text.isEmpty ? _validate = true : _validate = false;
                  _acreage = acreageCon.text;
                });

                _acreage.isNotEmpty ? Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => NewResultsScreen(
                                                        estimate: tmpEst,
                                                        )
                                                      ),
                ) : ArgumentError.notNull('Value Can\'t Be Empty');
              },
              child: Text('Calculate Estimate'),
            ),
          ],
        ),
      ),
    );
  }
}