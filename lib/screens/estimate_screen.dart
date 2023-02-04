import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/estimate.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/bottom_nav_bar.dart';

class EstimateScreen extends StatefulWidget {
  static const routeName = 'estimateScreen';

  const EstimateScreen({Key? key}) : super(key: key);

  @override
  State<EstimateScreen> createState() {
    return _EstimateScreenState();
  }
}

class EstimateScreenArgs {
  final bool isNew;
  final Estimate estimate;

  EstimateScreenArgs(this.isNew, this.estimate);
}

class _EstimateScreenState extends State<EstimateScreen> {
  @override
  Widget build(BuildContext context) {
    final EstimateScreenArgs args =
        ModalRoute.of(context)!.settings.arguments as EstimateScreenArgs;
    final Estimate estimate = args.estimate;
    final bool isNew = args.isNew;

    return WillPopScope(
        onWillPop: () async {
          if (isNew) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: const Text("Estimate Screen"),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                      height: 10,
                      width: double
                          .infinity), //invisible container to make column max-width
                  const Text(
                    "Acres Order",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                      height: 20,
                      width: double
                          .infinity), //invisible container to make column max-width
                  DataTable(
                    dataRowHeight: 30,
                    headingRowColor:
                        MaterialStateColor.resolveWith((states) => Colors.grey),
                    border: TableBorder.all(
                        color: const Color.fromARGB(255, 83, 83, 83)),
                    columns: const [
                      DataColumn(
                          label: Text('Name',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('NFES #',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Quantity',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)))
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text('Truck Line')),
                        const DataCell(Text('N/A')),
                        DataCell(Text(estimate.trunkLineLength.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Lat Line')),
                        const DataCell(Text('N/A')),
                        DataCell(Text(estimate.latLineLength.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Toy Line')),
                        const DataCell(Text('N/A')),
                        DataCell(Text(estimate.toyLineLength.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('1.5" Gated Wye')),
                        const DataCell(Text('000231')),
                        DataCell(Text(estimate.onePointFiveInchWye.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('1.5" Reducers')),
                        const DataCell(Text('000010')),
                        DataCell(
                            Text(estimate.onePointFiveInchReducer.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('1"-3/4" Reducers')),
                        const DataCell(Text('000733')),
                        DataCell(Text(estimate.fittings.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Forester Nozzles')),
                        const DataCell(Text('000024')),
                        DataCell(Text(estimate.fittings.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Toy Nozzles')),
                        const DataCell(Text('007387')),
                        DataCell(Text(estimate.fittings.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Toy Wye')),
                        const DataCell(Text('000904')),
                        DataCell(Text(estimate.fittings.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Fold-a-Tanks')),
                        const DataCell(Text('000664')),
                        DataCell(Text(estimate.foldaTanks.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Mark3 + Kits')),
                        const DataCell(Text('003870')),
                        DataCell(Text(estimate.mark3Kits.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Pump Mix (Cans)')),
                        const DataCell(Text('N/A')),
                        DataCell(Text(estimate.pumpCans.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Water Pallets')),
                        const DataCell(Text('N/A')),
                        DataCell(Text(estimate.waterPallets.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Gatorade Pallets')),
                        const DataCell(Text('N/A')),
                        DataCell(Text(estimate.gatoradePallets.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('MRE Pallets')),
                        const DataCell(Text('001842')),
                        DataCell(Text(estimate.mrePallets.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Port-a-Potties')),
                        const DataCell(Text('N/A')),
                        DataCell(Text(estimate.portaPottiesPallets.toString()))
                      ]),
                    ],
                  ),
                  const SizedBox(
                      height: 30,
                      width: double
                          .infinity), //invisible container to make column max-width
                  Container(child: shareAcresButton(estimate)),
                  const SizedBox(
                      height: 30,
                      width: double
                          .infinity), //invisible container to make column max-width
                  const Text(
                    "Structures Order",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                      height: 20,
                      width: double
                          .infinity), //invisible container to make column max-width
                  DataTable(
                    dataRowHeight: 30,
                    headingRowColor:
                        MaterialStateColor.resolveWith((states) => Colors.grey),
                    border: TableBorder.all(
                        color: const Color.fromARGB(255, 83, 83, 83)),
                    columns: const [
                      DataColumn(
                          label: Text('Name',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('NFES #',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Quantity',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)))
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text('Sprinkler Kits')),
                        const DataCell(Text('001048')),
                        DataCell(Text(estimate.sprinklerKits.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('1.5" Hose')),
                        const DataCell(Text('001239')),
                        DataCell(Text(estimate.onePointFiveHose.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('1.0" Hose')),
                        const DataCell(Text('001238')),
                        DataCell(Text(estimate.oneInchHose.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('1.5" Gated Wye')),
                        const DataCell(Text('000231')),
                        DataCell(Text(estimate.onePointFiveInchWye.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('1.0" Gated Wye')),
                        const DataCell(Text('000259')),
                        DataCell(Text(estimate.oneInchWye.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('1.0" - 1.5" Reducer')),
                        const DataCell(Text('000010')),
                        DataCell(
                            Text(estimate.onePointFiveInchReducer.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('KK Nozzles')),
                        const DataCell(Text('001081')),
                        DataCell(Text(estimate.kkNozzles.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Mark3 Pumps & Kits')),
                        const DataCell(Text('003870')),
                        DataCell(Text(estimate.mark3Structures.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Fold-a-Tanks')),
                        const DataCell(Text('000664')),
                        DataCell(Text(estimate.foldaTanks.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Unleaded Gas')),
                        const DataCell(Text('N/A')),
                        DataCell(Text(estimate.unleadedGas.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('2-Cycle Oil (Quart)')),
                        const DataCell(Text('N/A')),
                        DataCell(Text(estimate.twoCycleOil.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Port-a-Potties')),
                        const DataCell(Text('N/A')),
                        DataCell(Text(estimate.portaPottiesPallets.toString()))
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Foam (Cans)')),
                        const DataCell(Text('N/A')),
                        DataCell(Text(estimate.foam.toString()))
                      ]),
                    ],
                  ),
                  const SizedBox(height: 30, width: double.infinity),
                  Container(child: shareStructuresButton(estimate)),
                  const SizedBox(
                      height: 30,
                      width: double
                          .infinity), //invisible container to make column max-width
                  const SizedBox(
                      height: 30,
                      width: double
                          .infinity), //invisible container to make column max-width
                  DataTable(dataRowHeight: 30, columns: const [
                    DataColumn(
                        label: Text(
                      'Notes',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    )),
                    DataColumn(label: Text(''))
                  ], rows: const [
                    DataRow(cells: [
                      DataCell(Text('Incident Response Name')),
                      DataCell(SizedBox(width: 140, child: Text('')))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('POC Name')),
                      DataCell(Text(''))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('POC Number')),
                      DataCell(Text(''))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Dispatch Center')),
                      DataCell(Text(''))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Drop Points')),
                      DataCell(Text(''))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Delivery Instructions')),
                      DataCell(Text(''))
                    ]),
                    DataRow(
                        cells: [DataCell(Text('Comments')), DataCell(Text(''))])
                  ]),
                  const SizedBox(
                      height: 30,
                      width: double
                          .infinity), //invisible container to make column max-width
                ],
              ),
            ),
            bottomNavigationBar: const BottomNavBar()));
  }

  Widget? homeButton() {
    return FloatingActionButton(
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('/'));
          setState(() {});
        },
        heroTag: 'homeButton',
        child: const Icon(Icons.home));
  }

  Widget floatingActionButtonAcres(estimate, context) {
    return FloatingActionButton(
        heroTag: "CopyAcres",
        child: const Icon(Icons.copy),
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
        child: const Icon(Icons.copy),
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
      icon: const Icon(Icons.copy),
      label: const Text("Copy"),
    );
  }

  Widget? shareAcresButton(estimate) {
    String subject =
        "Acres Order"; //add estimate name to subject once names are implemented
    return FloatingActionButton.extended(
      onPressed: () {
        Share.share(estimate.flatFireOrderTextAndNotes(), subject: subject);
      },
      icon: const Icon(Icons.share),
      label: const Text("share"),
      heroTag: "shareAcres",
    );
  }

  Widget? shareStructuresButton(estimate) {
    String subject = "Structures Order";
    return FloatingActionButton.extended(
      onPressed: () {
        Share.share(estimate.structureFireOrderTextAndNotes(),
            subject: subject);
      },
      icon: const Icon(Icons.share),
      label: const Text("share"),
      heroTag: "shareStructures",
    );
  }
}
