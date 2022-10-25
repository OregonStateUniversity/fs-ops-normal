import 'package:flutter/material.dart';
import '../screens/about_screen.dart';
import '../screens/red_book_screen.dart';
import '../screens/how_to_screen.dart';
import '../screens/incident_response_pocket_guide_screen.dart';

class SideDrawer extends StatelessWidget {
  // @override
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        _topOfDrawer(context),
        _bottomOfDrawer(context),
      ],
    ));
  }

  Widget _topOfDrawer(BuildContext context) {
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

  Widget _bottomOfDrawer(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Column(
        children: [
          const Divider(),
          _drawerItem(Icons.info_outline, "About",
              () => Navigator.pushNamed(context, AboutScreen.routeName)),
        ],
      ),
    );
  }

  Widget _drawerHeader() {
    return const DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: Colors.black),
        child: Image(image: AssetImage('assets/icon/icon.png')));
  }

  Widget _drawerItem(IconData icon, String text, Function onTap) {
    return ListTile(
        title: Row(
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text),
            ),
          ],
        ),
        onTap: onTap as void Function()?);
  }
}
