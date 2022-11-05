import 'package:flutter/material.dart';
import '../event_handlers/popup_menu_button_handler.dart';

class SortPopupMenuButton extends StatelessWidget {
  final PopupMenuButtonHandler popupMenuButtonHandler;

  const SortPopupMenuButton({Key? key, required this.popupMenuButtonHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(Icons.sort),
        itemBuilder: (context) => [
              const PopupMenuItem(value: 'newest', child: Text('Newest')),
              const PopupMenuItem(value: 'oldest', child: Text('Oldest')),
            ],
        onSelected: (String value) => popupMenuButtonHandler.onSelected(value));
  }
}
