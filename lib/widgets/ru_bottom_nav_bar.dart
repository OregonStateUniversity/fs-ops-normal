import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hose_jockey/Widgets/bottom_nav_bar.dart';


class RU_BottomNavBar extends StatefulWidget{
  String goBack;
  RU_BottomNavBar({Key? key, required this.goBack}) : super(key:key);

  @override
  RU_BottomNavBarState createState() => RU_BottomNavBarState();
}

class RU_BottomNavBarState extends State<RU_BottomNavBar>{
  @override
  Widget build(BuildContext context){
    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? Colors.red : Colors.white;
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
        switch(index){
          case 0:
            Navigator.popUntil(context, ModalRoute.withName('/'));
            _onTap(index);
            break;
          case 1:
              Navigator.popUntil(context, ModalRoute.withName(widget.goBack.toString()));
              _onTap(index);
            break;
        }
      },
    );
  }

  int? activeIndex;
  var _bottomNavIndex = 3;
  final autoSizeGroup = AutoSizeGroup();

  List<BottomIcons> iconList = [
    BottomIcons("Home", Icons.home_filled),
    BottomIcons("Back", Icons.arrow_back),
  ];

  void _onTap(int index) {
    setState((){
      _bottomNavIndex = index;
    });
  }
}


