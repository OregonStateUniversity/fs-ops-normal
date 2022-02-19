import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/bottom_nav_bar.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = 'about';
  static const title = "About";

  static const TextAlign align = TextAlign.center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Align(
            alignment: FractionalOffset.center,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Created By Josh C. and Kyle H. for",
                    textAlign: align,
                  ),
                  Text(
                    "OSU-Cascades Computer Science Final Project",
                    textAlign: align,
                  ),
                  Divider(),
                  Text(
                    "Ops Normal is an application designed for wild land firefighters to "
                    "quickly estimate the amount of equipment that they will need to fight a fire",
                    textAlign: align,
                  ),
                  Divider(),
                  Text(
                    "\nThe source code for this project can be found at: ",
                    textAlign: align,
                  ),
                  TextButton(
                      onPressed: () => launch(
                          'https://github.com/osu-cascades/fs-hose-jockey'),
                      child: Text(
                          "https://github.com/osu-cascades/fs-hose-jockey"))
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(goBack: '/'),
    );
  }
}
