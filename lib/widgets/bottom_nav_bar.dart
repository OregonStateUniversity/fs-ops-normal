import 'package:flutter/material.dart';
import '../screens/compass_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, this.showHome = true, this.leftButtonFunction})
      : super(key: key);

  final bool? showHome;
  final Function? leftButtonFunction;

  @override
  State<BottomNavBar> createState() {
    return _BottomNavBarState();
  }
}

class _BottomNavBarState extends State<BottomNavBar> {
  late bool leftButtonFunctionProvided =
      widget.leftButtonFunction == null ? false : true;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: navButtons(),
      iconSize: 35,
      onTap: (int index) {
        setState(() {});
        switch (index) {
          case 0:
            if (leftButtonFunctionProvided) {
              widget.leftButtonFunction!();
            } else {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            }
            break;
          case 1:
            showCompass();
            break;

          case 2:
            showCompass();
            break;
        }
      },
    );
  }

  showCompass() {
    Navigator.pushNamed(context, CompassScreen.routeName);
  }

  List<BottomNavigationBarItem> navButtons() {
    List<BottomNavigationBarItem> buttons = [leftButton(), compassButton()];
    return buttons;
  }

  BottomNavigationBarItem leftButton() {
    return BottomNavigationBarItem(
      label: "",
      icon:
          widget.showHome! ? const Icon(Icons.home) : const Icon(Icons.archive),
    );
  }

  BottomNavigationBarItem compassButton() {
    return const BottomNavigationBarItem(
      label: "",
      icon: Icon(Icons.explore_outlined),
    );
  }
}
