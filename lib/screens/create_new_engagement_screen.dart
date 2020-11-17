import 'package:flutter/material.dart';


class CreateNewEngagement extends StatefulWidget{

  static const routeName = 'newEngagement';

  _CreateNewEngagementState createState() => _CreateNewEngagementState();

}

class _CreateNewEngagementState extends State<CreateNewEngagement> {

  Widget _buildNameField() {
    return const TextField(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Engagement"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          const ListTile(title: Text('Name Fire')),
          _buildNameField(),
          const ListTile(title: Text('Set initial acreage')),
          _buildAcreageField(),
        ],
      )
    );
  }
}

// TODO: 
    //       -implement form fields
    //       -data variables
    //       -each new engagement created should have a name and a bool set to active
    //throw UnimplementedError();