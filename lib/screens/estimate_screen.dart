import 'dart:ffi';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hose_jockey/Widgets/bottom_nav_bar.dart';
import '../Widgets/ru_bottom_nav_bar.dart';
import '../models/estimate.dart';

class EstimateScreen extends StatelessWidget{

  static const routeName = 'estimateScreen';

  @override
  Widget build(BuildContext context) {

    final Estimate estimate = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Copy Your Order"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: SelectableText(
                    estimate.toCopyString()
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: floatingActionButton(estimate, context),
      bottomNavigationBar: RU_BottomNavBar(goBack: 'engagement')
    );
  }

  int activeIndex;
  var _bottomNavIndex = 3;
  final autoSizeGroup = AutoSizeGroup();

  List<BottomIcons> iconList = [
    BottomIcons("Home", Icons.home_filled),
    BottomIcons("Back", Icons.arrow_back),
  ];

  Widget bottomNavBar(context){
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
      backgroundColor: Colors.blueGrey[900],
      onTap: (index) { 
        switch(index){
          case 0:
            Navigator.popUntil(context, ModalRoute.withName('/'));
            break;
          case 1:
            Navigator.popUntil(context, ModalRoute.withName('engagement'));
            break;
        }
      },
    );
  }

  Widget floatingActionButton(estimate, context){
    return FloatingActionButton(
      child: Icon(Icons.copy),
        onPressed: (){
      Clipboard.setData(
              ClipboardData(text: estimate.toCopyString())
          )
                .then((value)
            => ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("Copied to Clipboard"),)
            )
            );
          }
      );
  }

  Widget floatAccButton(estimate, context){
    return FloatingActionButton.extended(
        onPressed: (){
          Clipboard.setData(
              ClipboardData(text: estimate.toCopyString())
            )
            .then((value) 
              => ScaffoldMessenger.of(context)
              .showSnackBar(
                const SnackBar(content: Text("Copied to Clipboard"),)
              )
            );
        },
        icon: Icon(Icons.copy),
        label: Text("Copy"),
      );
  }

}
