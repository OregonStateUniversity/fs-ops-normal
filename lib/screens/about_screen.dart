import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = 'about';
  static const title = "About";

  static const TextAlign align = TextAlign.center;
  static const sourceCodeURL = "https://github.com/osu-cascades/fs-ops-normal";
  static const createdBy =
      "Created By \nBen Shiffman, Aimee Bogle, \nAzzam Muthanna, Ian Snyder, \nErin O'Connell, Kelson Denton, \nJosh C., Kyle H. for";
  static const createdFor = "U.S. Forest Service";
  static const about =
      "Ops Normal is an application designed for wildland firefighters to quickly estimate the amount of equipment that they will need to fight a fire.";
  static const sourceCodeText =
      "\nThe source code for this project can be found at: ";

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Column(
        children: [
          Align(
            alignment: FractionalOffset.center,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    createdBy,
                    textAlign: align,
                  ),
                  const Text(
                    createdFor,
                    textAlign: align,
                  ),
                  const Divider(),
                  const Text(
                    about,
                    textAlign: align,
                  ),
                  const Divider(),
                  const Text(
                    sourceCodeText,
                    textAlign: align,
                  ),
                  TextButton(
                      onPressed: () => launchUrlString(sourceCodeURL),
                      child: const Text(sourceCodeURL))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
