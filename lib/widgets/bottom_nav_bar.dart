import 'package:flutter/material.dart';
import '../screens/compass_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(
      {Key? key,
      this.showHome = true,
      this.leftButtonFunction,
      this.onCompassScreen = false})
      : super(key: key);

  final bool? showHome;
  final Function? leftButtonFunction;
  final bool? onCompassScreen;

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
            if (!widget.onCompassScreen!) {
              showCompass();
            }
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
      icon: widget.showHome!
          ? const Icon(Icons.home, color: Colors.green)
          : const Icon(Icons.archive, color: Colors.green),
    );
  }

  BottomNavigationBarItem compassButton() {
    return BottomNavigationBarItem(
      label: "",
      icon: widget.onCompassScreen!
          ? const Icon(Icons.explore_outlined)
          : const Icon(Icons.explore_outlined, color: Colors.green),
    );
  }
}
