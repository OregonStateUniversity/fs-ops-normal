import 'package:flutter/material.dart';

class HidableFloatingActionButton extends StatelessWidget {

  final bool visible;
  final String? tooltip;
  final Widget? child;
  final VoidCallback? onPressed;

  const HidableFloatingActionButton({Key? key, required this.visible,
    this.tooltip, this.child, this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: this.visible,
      child: FloatingActionButton(
        onPressed: this.onPressed,
        tooltip: this.tooltip,
        child: this.child,
      ),
    );
  }
}
