import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'bottom_icon.dart';

class BottomNavBar extends StatefulWidget {
  final String goBack;
  const BottomNavBar({Key? key, required this.goBack}) : super(key: key);

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      tabBuilder: (int index, bool isActive) {
        const Color yellow99 = Color.fromRGBO(255, 227, 99, 1);
        final color = isActive ? yellow99 : Colors.white;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconList[index].icon,
              size: 24,
              color: color,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AutoSizeText(
                iconList[index].name,
                maxLines: 1,
                style: TextStyle(color: color),
                group: autoSizeGroup,
              ),
            )
          ],
        );
      },
      backgroundColor: (Colors.blueGrey[900]!),
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.popUntil(context, ModalRoute.withName('/'));
            _onTap(index);
            break;
          case 1:
            Navigator.popUntil(context, ModalRoute.withName(widget.goBack));
            _onTap(index);
            break;
        }
      },
    );
  }

  int? activeIndex;
  var _bottomNavIndex = 3;
  final autoSizeGroup = AutoSizeGroup();

  List<BottomIcon> iconList = [
    BottomIcon("Home", Icons.home_filled),
    BottomIcon("Archive", Icons.archive)
  ];

  void _onTap(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }
}
