import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                    _howToCreateFirstEngagementAndOrder(),
                    Divider(),
                    _howToArchiveEngagement(),
                    Divider(),
                    _howToUnArchiveEngagement(),
                    Divider(),
                    _howToDeleteEngagementOrOrder(),
                    Divider(),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _howToCreateFirstEngagementAndOrder(){
    return Column(
      children: [
        Text("\nCreating your first engagement and order:\n"),
        Text("1. On the home page click the bottom plus(+) button to create a new engagement. And engagement is a fire that you are currently working.\n"
            "\t\t\ta. Give the engagement a name, something to describe the fire like location\n"
            "\t\t\tb. Click the 'Create' button\n"
            "\t\t\tc. You should see a new engagement show up on the screen with the name you've just entered.", textAlign: align,),
        Text("\n2. Tap on the newly created engagement.\n"
            "\t\t\ta. Click on the bottom plus(+) button to create a new order.\n"
            "\t\t\tb. Inside the popup input the acreage of the fire.\n"
            "\t\t\tc. Click on the 'Calculate Estimate' button.\n"
            "\t\t\td. On this page you are now able to edit the amount of equipment that you want. Once your numbers are correct, click the 'Save' button\n"
            "\t\t\te. From here you will be able to see and copy the order that you've just created. To copy click the 'Tap Here To Copy' button.\n", textAlign: align,),
        Text("\n3. Now that the order is done and copied to your clipboard you now send it to the individual who processes the delivery\n"
            "\t\t\ta. Once you are done and want to create another order, tap the 'Back' button and it will take you back to the list of orders with your newly created order there as well\n"
            "\t\t\tb. To go back and create another engagement tap the 'Home' button.", textAlign: align,),
      ],
    );
  }

  Widget _howToArchiveEngagement(){
    return Column(
      children: [
        Text("\nHow to archive an engagement:\n"),
        Text("1. On the main page find the engagement that you wish to archive.\n"
            "\t\t\ta. Tap and hold the left side of the screen on the engagement and slide to the right.\n"
            "\t\t\tb. A popup will ask you to confirm the archive. Tap on the 'Archive' button to confirm.\n", textAlign: align,),
      ],
    );
  }

  Widget _howToUnArchiveEngagement(){
    return Column(
      children: [
        Text("\nHow to un archive an engagement:\n"),
        Text("1. First you need to get to the archive page by tapping on the 'Archive' button in the bottom left corner.\n"
            "\t\t\ta. Once you are on this page you now need to locate the engagement that you want to un archive.\n"
            "\t\t\tb. Once located you need to tap and hold the left side of the screen on the engagement and slide it to the right.\n"
            "\t\t\tc. A popup will ask you to confirm the un archive. Tap on the 'Un Archive' button\n", textAlign: align,),
      ],
    );
  }

  Widget _howToDeleteEngagementOrOrder(){
    return Column(
      children: [
        Text("\nHow to delete an engagement or order:\n"),
        Text("1. Find the engagement or order that you want to delete.\n"
            "\t\t\ta. Tap and hold the left side of the screen on the engagement or order and slide it to the right.\n"
            "\t\t\tb. A popup will ask you to confirm the deletion. Tap on the 'Delete' button. Warning: This cannot be undone.", textAlign: align,),

      ],
    );
  }
}