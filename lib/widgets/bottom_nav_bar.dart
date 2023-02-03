import 'package:flutter/material.dart';
import '../screens/compass_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(
      {Key? key, this.showHome = true, this.addButton, this.leftButtonFunction})
      : super(key: key);

  final bool? showHome;
  final Function? leftButtonFunction;
  final Widget? addButton;

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
              if (widget.leftButtonFunction != null) {
                widget.leftButtonFunction!();
              } else {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              }
            },
            tooltip: "toggle home or archive",
            heroTag: "homeButton",
            // ignore: unnecessary_null_comparison
            child: widget.showHome!
                ? const Icon(Icons.home)
                : const Icon(Icons.archive),
          ),
          widget.addButton!,
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
