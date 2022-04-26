import 'package:flutter/material.dart';
import '../persistence/database_manager.dart';
import '../persistence/engagement_dao.dart';
import '../persistence/engagement_dto.dart';

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
      onPressed: () => Navigator.of(context).pop(false)
    );
  }

  Widget _saveButton(BuildContext context) {
    return OutlinedButton(
      child: const Text('Save'),
      onPressed: () {
        final dto = EngagementDTO(
          name: engagementNameTextFieldController.text,
          active: true,
          createdAt: DateTime.now());
        EngagementDAO.save(databaseManager: DatabaseManager.getInstance(), dto: dto);
        Navigator.of(context).pop(true);
      },
    );
  }

}
