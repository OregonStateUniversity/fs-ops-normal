import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hose_jockey/how_to_instructions_strings.dart';

class HowTo extends StatelessWidget{
  static const routeName = 'howto';
  static const title = "How To Use";

  static const TextAlign align = TextAlign.center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: FractionalOffset.center,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _cardItem(HowToCreateEngagementAndOrder.title, HowToCreateEngagementAndOrder.description),
                    Divider(),
                    _cardItem(HowToDeleteEngagementOrOrder.title, HowToDeleteEngagementOrOrder.description),
                    Divider(),
                    _cardItem(HowToArchiveEngagement.title, HowToArchiveEngagement.description),
                    Divider(),
                    _cardItem(HowToUnarchiveEngagement.title, HowToUnarchiveEngagement.description),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _cardItem(String title, String description){
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
          top: 6.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(title),
          children: [
            Text("$description")
          ],
        )
      ),
    );
  }
}