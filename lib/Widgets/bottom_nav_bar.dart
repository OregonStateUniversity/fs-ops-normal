import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final AnimationController? controller;
  final int? index;
  final Key? key;
  final Function? onTap;

  const BottomNavBar({ this.controller, this.index, this.key, this.onTap}) : super(key:key);

  @override
  Widget build(context) {
    return AnimatedBottomNavigationBar(
      icons: [
        Icons.home_filled,
        Icons.post_add_outlined,
        Icons.sort,
        Icons.archive_outlined
      ],
      notchAndCornersAnimation: controller!,
      activeIndex: this.index!,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      onTap: (index) => onTap!(index),
    );
  }
}

class BottomIcons {
  String name;
  IconData icon;


  BottomIcons(this.name, this.icon);
  
}