import 'dart:developer';

class FloatingActionButtonHandler {
  void Function() onPressed = () {
    log("Warning: This event handler should be assigned a new function.");
  };
}
