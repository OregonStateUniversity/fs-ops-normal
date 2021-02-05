import 'package:flutter/material.dart';
import '../models/engagement.dart';
import 'main_screen.dart';

class CreateNewEngagement extends StatefulWidget{

  static const routeName = 'newEngagement';

  _CreateNewEngagementState createState() => _CreateNewEngagementState();

}

class _CreateNewEngagementState extends State<CreateNewEngagement> {
  final GlobalKey<_CreateNewEngagementState> _key = GlobalKey();

  List<Engagement> engagements = [];

  TextEditingController engagementCtrl = TextEditingController();
  TextEditingController acreageCtrl = TextEditingController();

  void setEngagement(Engagement engagement) {
    engagements.add(engagement);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Engagement"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          //const ListTile(title: Text('Name Fire')),
          //_buildNameField(),
          TextField(
            controller: engagementCtrl,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            maxLines: 1,
            decoration: InputDecoration(
              labelText: 'Enter fire name:',
              border: const OutlineInputBorder(),
            ),
          ),
          const ListTile(title: Text('Set initial acreage')),
          //_buildAcreageField(),
          TextField(
            controller: acreageCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter acreage:',
              errorText:_acreageInputIsValid ? null: 'Please enter a number',
              border: const OutlineInputBorder(),
            ),
          ),
          
          OutlineButton(
            child: Text('cancel'),
            onPressed:() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
          OutlineButton(
            child: Text('Create'),
            onPressed: () {
              _key.currentState
                  .setEngagement(Engagement(
                    engagementCtrl.text,
                    '10-23-20',
                    int.parse(acreageCtrl.text),
                    [],
                    1,
                  ));
              setState(() {

              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          )

        ],
      )
    );
  }
}

  Widget _buildNameField(context) {
    return TextField(
      //controller: engagementCtrl,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: 'Enter fire name:',
        border: const OutlineInputBorder(),
      ),
    );
  }

  bool _acreageInputIsValid = true;

  Widget _buildAcreageField() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Enter acreage:',
        errorText:_acreageInputIsValid ? null: 'Please enter a number',
        border: const OutlineInputBorder(),
      ),
    );
  }