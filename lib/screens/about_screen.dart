import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = 'about';
  static const title = "About";

  static const TextAlign align = TextAlign.center;
  static const SOURCE_CODE_URL =
      "https://github.com/osu-cascades/fs-hose-jockey";

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
                    "Created By Ben Shiffman,\nIan Snyder, Erin O'Connell, \n Josh C., Kyle H. for",
                    textAlign: align,
                  ),
                  Text(
                    "U.S. Forest Service",
                    textAlign: align,
                  ),
                  Divider(),
                  Text(
                    "Ops Normal is an application designed for wildland firefighters to "
                    "quickly estimate the amount of equipment that they will need to fight a fire.",
                    textAlign: align,
                  ),
                  Divider(),
                  Text(
                    "\nThe source code for this project can be found at: ",
                    textAlign: align,
                  ),
                  TextButton(
                      onPressed: () => launch(SOURCE_CODE_URL),
                      child: Text(SOURCE_CODE_URL))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
