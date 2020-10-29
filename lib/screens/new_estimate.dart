import 'package:flutter/material.dart';
import 'results_screen.dart';

//class NewEstimateScreen extends StatelessWidget {
//  @override
// Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('New Estimate'),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text('Enter Acreage',
//            ),
//            TextField(
//              keyboardType: TextInputType.number,
//              decoration: InputDecoration(
//                hintText: "Acreage"
//              ),
//            ),
//            OutlineButton(
//                onPressed: (){
//                  // Show results when clicked
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => NewResultsScreen()),
//                  );
//                },
//                child: Text('Calculate Estimate'),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}



class NewEstimateScreen extends StatefulWidget{

  _NewEstimateScreenState createState() => _NewEstimateScreenState();
}

class _NewEstimateScreenState extends State<NewEstimateScreen> {
  var _acreage = '0';
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
                  hintText: "Acreage"
              ),
            ),
            OutlineButton(
              onPressed: (){
                setState(() {
                  _acreage = acreageCon.text;
                });
                // Show results when clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewResultsScreen(
                    acreage: _acreage,
                    )
                  ),
                );
              },
              child: Text('Calculate Estimate'),
            ),
            Text("You entered $_acreage into the text field"),
          ],
        ),
      ),
    );
  }
}