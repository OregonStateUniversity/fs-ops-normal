import 'dart:developer';

class PopupMenuButtonHandler {
  void Function(String value) onSelected = (value) {
    log("Warning: This event handler should be assigned a new function.");
  };
}
