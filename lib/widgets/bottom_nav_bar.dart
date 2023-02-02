import 'package:flutter/material.dart';
import '../screens/compass_screen.dart';
import '../widgets/hidable_floating_action_button.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(
      {Key? key,
      required this.goBack,
      required this.isMainScreen,
      required this.toggle,
      required this.tabIndex,
      required this.addButtonVisible,
      required this.addButtonHandler})
      : super(key: key);

  final String goBack;
  final bool isMainScreen;
  final Function toggle;
  final int tabIndex;
  final bool addButtonVisible;
  final Function addButtonHandler;

  @override
  State<BottomNavBar> createState() {
    return _BottomNavBarState();
  }
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                color: Color.fromARGB(67, 255, 255, 255))
          ],
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromARGB(32, 133, 131, 131)),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        // direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              if (widget.isMainScreen) {
                widget.toggle();
              } else {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              }
              setState(() {});
            },
            tooltip: "toggle home or archive",
            heroTag: "homeButton",
            child: widget.tabIndex == 1
                ? const Icon(Icons.archive)
                : const Icon(Icons.home),
          ),
          HidableFloatingActionButton(
              visible: widget.addButtonVisible,
              onPressed: () => widget.addButtonHandler,
              tooltip: 'New engagement',
              child: const Icon(Icons.add)),
          FloatingActionButton(
            heroTag: "compassButton",
            tooltip: "view compass",
            onPressed: () {
              Navigator.pushNamed(context, CompassScreen.routeName);
            },
            child: const Icon(Icons.explore_outlined),
          )
        ],
      ),
    );
  }
}
