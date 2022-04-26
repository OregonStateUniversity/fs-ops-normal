import 'package:flutter/material.dart';

class NewEngagementDialog extends StatelessWidget {
  
  NewEngagementDialog({ Key? key }) : super(key: key);

  final engagementNameTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create New Engagement'),
      content: TextField(
        autofocus: true,
        controller: engagementNameTextFieldController,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: 'Engagement Name:',
          border: const OutlineInputBorder(),
        ),
      ),
      actions: <Widget>[
        OutlinedButton(
          child: Text('Cancel'),
          onPressed: () {
            engagementNameTextFieldController.clear();
            Navigator.of(context).pop();
          },
        ),
        OutlinedButton(
          key: Key('create engagement'),
          child: Text('Create'),
          onPressed: () async {
            final engagementName = engagementNameTextFieldController.text;
            // setEngagement();
            // DatabaseHelper.insertEngagement(dto);
            // loadEngagements();
            Navigator.of(context).pop();
          },
        ),
      ]
    );
  }
}