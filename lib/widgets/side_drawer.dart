import 'package:flutter/material.dart';
import '../screens/about_screen.dart';
import '../screens/red_book_screen.dart';
import '../screens/how_to_screen.dart';
import '../screens/incident_response_pocket_guide_screen.dart';

class SideDrawer extends StatefulWidget {
  @override
  SideDrawerState createState() => SideDrawerState();
}

class SideDrawerState extends State<SideDrawer> {
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        _topOfDrawer(),
        _bottomOfDrawer(),
      ],
    ));
  }

  Widget _topOfDrawer() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _drawerHeader(),
          _drawerItem(Icons.question_answer_outlined, "How To Use Ops Normal",
              () => Navigator.pushNamed(context, HowToScreen.routeName)),
          _drawerItem(
              Icons.book_outlined,
              "Interagency Standard for Fire\nand Fire Aviation Operations",
              () => Navigator.pushNamed(context, RedBookScreen.routeName)),
          _drawerItem(
              Icons.book_outlined,
              "Incident Response Pocket Guide",
              () => Navigator.pushNamed(
                  context, IncidentResponsePocketGuideScreen.routeName)),
        ],
      ),
    );
  }

  Widget _bottomOfDrawer() {
    return Container(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          child: Column(
            children: [
              Divider(),
              _drawerItem(Icons.info_outline, "About",
                  () => Navigator.pushNamed(context, AboutScreen.routeName)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('lib/assets/icon/OpsNormal_IOS.png'),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              "",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String text, Function onTap) {
    return ListTile(
        title: Row(
          children: [
            Icon(icon),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(text),
            ),
          ],
        ),
        onTap: onTap as void Function()?);
  }
}
