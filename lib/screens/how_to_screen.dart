import 'package:flutter/material.dart';
import '../utils/how_to_instructions_strings.dart';
import '../widgets/bottom_nav_bar.dart';

class HowToScreen extends StatelessWidget {
  static const routeName = 'howto';
  static const title = "How To Use Ops Normal";

  static const TextAlign align = TextAlign.center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Semantics(
        label: "A list of instructions about how to use Ops Normal",
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: FractionalOffset.center,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _cardItem(HowToCreateEngagementAndOrder.title,
                          HowToCreateEngagementAndOrder.description),
                      _cardItem(HowToDeleteEngagementOrOrder.title,
                          HowToDeleteEngagementOrOrder.description),
                      _cardItem(HowToArchiveEngagement.title,
                          HowToArchiveEngagement.description),
                      _cardItem(HowToUnarchiveEngagement.title,
                          HowToUnarchiveEngagement.description),
                      Divider(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(goBack: '/'),
    );
  }

  Widget _cardItem(String title, String description) {
    return Semantics(
        readOnly: false,
        label: "Dropdown description for how to use Ops Normal",
        child: Card(
          child: Padding(
              padding:
                  EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 6.0),
              child: ExpansionTile(
                title: Text(title),
                children: [Text("$description")],
              )),
        ));
  }
}
