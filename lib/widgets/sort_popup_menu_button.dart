import 'package:flutter/material.dart';
import '../event_handlers/popup_menu_button_handler.dart';

class SortPopupMenuButton extends StatelessWidget {

  final PopupMenuButtonHandler popupMenuButtonHandler;

  const SortPopupMenuButton({Key? key, required this.popupMenuButtonHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.sort),
      itemBuilder: (context) => [
        PopupMenuItem(value: 'newest', child: const Text('Newest')),
        PopupMenuItem(value: 'oldest', child: const Text('Oldest')),
      ],
      onSelected: (String value) => popupMenuButtonHandler.onSelected(value)
    );
  }
}
