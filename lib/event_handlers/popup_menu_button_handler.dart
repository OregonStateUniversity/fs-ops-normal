import 'dart:developer';

class PopupMenuButtonHandler {
  void Function(String value) onSelected = (value) {
    //log: only print the debug mode. won't print the release mode
    log("Warning: This event handler should be assigned a new function.");
  };
}
