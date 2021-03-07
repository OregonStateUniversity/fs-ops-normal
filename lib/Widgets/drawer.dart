import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hose_jockey/screens/about_screen.dart';
import 'package:hose_jockey/screens/how_to_screen.dart';

class SideDrawer extends StatefulWidget {

  @override
  SideDrawerState createState() => SideDrawerState();
}

class SideDrawerState extends State<SideDrawer> {

  static const _email = "issues@opsnormal.com"; // doesn't actually exist.

  var appVersion = "0.0.0";

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [
            _topOfDrawer(),
            _bottomOfDrawer(),
          ],
        )
    );
  }

  Widget _topOfDrawer(){
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _drawerHeader(),
          _drawerItem(Icons.slideshow, "How To Use Ops Normal", () => Navigator.pushNamed(context, HowTo.routeName)),
          _drawerItem(Icons.settings_applications_outlined, "Visual Settings", ()=>{})
          //_drawerItem(Icons.article_outlined, "Documentation", ()=>{}),
        ],
      ),
    );
  }

  Widget _bottomOfDrawer(){
    return Container(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          child: Column(
            children: [
              Divider(),
              _drawerItem(Icons.info_outline, "About", () =>
                  Navigator.pushNamed(context, AboutScreen.routeName)),
              _drawerItem(Icons.bug_report, "Report An Issue", () =>
                  launch("mailto:$_email?subject=Version $appVersion&body=Describe the issue below\n")),

              Container(
                child: Text("Version $appVersion"),
                color: Colors.red[200],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerHeader() {
    return
      DrawerHeader(
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
              child: Text("",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                ),
              ),
            )
          ],
        ),
      );
  }

  Widget _drawerItem(IconData icon, text, onTap) {
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
        onTap: onTap
    );
  }
}

