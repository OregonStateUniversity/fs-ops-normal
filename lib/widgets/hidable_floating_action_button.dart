import 'package:flutter/material.dart';

class HidableFloatingActionButton extends StatelessWidget {

  final bool visible;
  final String tooltip;
  final Widget child;
  final VoidCallback onPressed;

  const HidableFloatingActionButton({Key? key, required this.visible,
    required this.tooltip, required this.child, required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: this.visible,
      child: FloatingActionButton(
        tooltip: this.tooltip,
        child: this.child,
        onPressed: this.onPressed
      )
    );
  }

}
