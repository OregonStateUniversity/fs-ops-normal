import 'package:flutter/material.dart';
//import 'active_engagement_list_screen.dart';
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

  var myControllerAcreage = TextEditingController(text: "0");
  var myControllerStructure = TextEditingController(text: "0");

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
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Enter Acreage',
                  errorText: _acreageInputIsValid ? null : 'error',
                  border: OutlineInputBorder())),
          const Padding(padding: EdgeInsets.all(10)),
          TextField(
              controller: myControllerStructure,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Enter Structures',
                  errorText: _structureInputIsValid ? null : 'error',
                  border: OutlineInputBorder())),
          OutlinedButton(
              onPressed: () {
                var estimate = Estimate(
                    acres: int.parse(myControllerAcreage.text),
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
      /*bottomNavigationBar: BottomNavigationBar(
        backgroundColor: (Colors.blueGrey[900]!),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: (Colors.blueGrey[900]!),
        onTap: _onItemTapped,
      ),*/
    );
  }
}
