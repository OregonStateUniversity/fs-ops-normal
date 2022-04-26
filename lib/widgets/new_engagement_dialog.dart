import 'package:flutter/material.dart';

class NewEngagementDialog extends StatelessWidget {
  
  NewEngagementDialog({ Key? key }) : super(key: key);

  final engagementNameTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Engagement'),
      content: _nameField(),
      actions: <Widget>[_cancelButton(context), _saveButton(context)]
    );
  }

  Widget _nameField() {
    return TextField(
      autofocus: true,
      controller: engagementNameTextFieldController,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        labelText: 'Engagement Name:',
        border: const OutlineInputBorder(),
      )
    );
  }

  Widget _cancelButton(BuildContext context) {
    return OutlinedButton(
      child: const Text('Cancel'),
      onPressed: () => Navigator.of(context).pop()
    );
  }

  Widget _saveButton(BuildContext context) {
    return OutlinedButton(
      child: const Text('Save'),
      onPressed: () async {
        final engagementName = engagementNameTextFieldController.text;
        // setEngagement();
        // DatabaseHelper.insertEngagement(dto);
        // loadEngagements();
        Navigator.of(context).pop();
      },
    );
  }

}
