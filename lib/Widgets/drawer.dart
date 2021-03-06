import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hose_jockey/screens/about_screen.dart';

class SideDrawer extends StatefulWidget {

  @override
  SideDrawerState createState() => SideDrawerState();
}

class SideDrawerState extends State<SideDrawer> {

  static const _email = "issues@opsnormal.com";

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _drawerHeader(),
                  _drawerItem(
                      Icons.slideshow, "How To Use Ops Normal", () => {}),
                  //_drawerItem(Icons.article_outlined, "Documentation", ()=>{}),
                ],
              ),
            ),
            Container(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  child: Column(
                    children: [
                      Divider(),
                      _drawerItem(Icons.info_outline, "About", () =>
                          Navigator.pushNamed(context, AboutScreen.routeName)),
                      _drawerItem(Icons.bug_report, "Report An Issue", () =>
                          launch("mailto:$_email")),
                      Text("App version 0.0.0"),
                    ],
                  ),
                ),
              ),
            )
          ],
        )

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

