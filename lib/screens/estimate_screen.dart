import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/estimate.dart';
import '../widgets/bottom_nav_bar.dart';

class EstimateScreen extends StatelessWidget {
  static const routeName = 'estimateScreen';

  @override
  Widget build(BuildContext context) {
    final Estimate estimate =
        ModalRoute.of(context)!.settings.arguments as Estimate;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Estimate Screen"),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(25)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Acres Order",
                  style: TextStyle(color: Colors.orange, fontSize: 25.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: SelectableText(estimate.toCopyStringAcres()),
                    ),
                  ],
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(10)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Structure Order",
                  style: TextStyle(color: Colors.orange, fontSize: 25.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: SelectableText(estimate.toCopyStringStructures()),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: floatingActionButton(estimate, context),
        bottomNavigationBar: BottomNavBar(goBack: 'engagement'));
  }

  Widget floatingActionButton(estimate, context) {
    return FloatingActionButton(
        child: Icon(Icons.copy),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: estimate.toCopyString())).then(
              (value) =>
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Copied to Clipboard"),
                  )));
        });
  }

  Widget floatAccButton(estimate, context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: estimate.toCopyString())).then(
            (value) =>
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Copied to Clipboard"),
                )));
      },
      icon: Icon(Icons.copy),
      label: Text("Copy"),
    );
  }
}
