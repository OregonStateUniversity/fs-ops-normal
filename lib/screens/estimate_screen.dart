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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 10,
                  width: double
                      .infinity), //invisible container to make column max-width
              Text(
                "Acres Order",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                  child: SelectableText(
                estimate.flatFireOrderText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              )),
              Container(child: floatingActionButtonAcres(estimate, context)),
              Container(
                  height: 50,
                  width: double
                      .infinity), //invisible container to make column max-width
              Text(
                "Structures Order",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                  child: SelectableText(
                estimate.structureFireOrderText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              )),
              Container(
                  child: floatingActionButtonStructures(estimate, context)),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(goBack: 'engagement'));
  }

  Widget floatingActionButtonAcres(estimate, context) {
    return FloatingActionButton(
        heroTag: "CopyAcres",
        child: Icon(Icons.copy),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: estimate.flatFireOrderText()))
              .then((value) =>
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Copied to Clipboard"),
                  )));
        });
  }

  Widget floatingActionButtonStructures(estimate, context) {
    return FloatingActionButton(
        heroTag: "CopyStructures",
        child: Icon(Icons.copy),
        onPressed: () {
          Clipboard.setData(
                  ClipboardData(text: estimate.structureFireOrderText()))
              .then((value) =>
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
