import 'package:flutter/material.dart';
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
                  _spacerSizedBox(20.0), // Spacer box
                  // Acres Order DataTable
                  _titleTextWidget("Acres Order", Colors.orange, 25.0),
                  _spacerSizedBox(20.0), // Spacer box
                  _acresDataTable(estimate),
                  _spacerSizedBox(30.0), // Spacer box
                  // Acres Order Share button
                  Container(child: shareAcresButton(estimate)),
                  _spacerSizedBox(30.0), // Spacer box
                  // Structures Order DataTable
                  _titleTextWidget("Structures Order", Colors.orange, 25.0),
                  _spacerSizedBox(25.0), // Spacer box
                  _structuresDataTable(estimate),
                  _spacerSizedBox(30.0), // Spacer box
                  // Structures Order Share button
                  Container(child: shareStructuresButton(estimate)),
                  _spacerSizedBox(35.0), // Spacer box
                  // Notes DataTable
                  _titleTextWidget(
                      "Tips for General Message", Colors.orange, 25.0),
                  _notesDataTable(estimate),
                  _spacerSizedBox(30.0),
                  Container(child: shareEverythingButton(estimate)),
                  _spacerSizedBox(30.0), // Spacer box
                  // Spacer box
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

  Widget? shareAcresButton(estimate) {
    String subject =
        "Acres Order"; //add estimate name to subject once names are implemented
    return FloatingActionButton.extended(
      onPressed: () {
        Share.share(estimate.flatFireOrderTextAndNotes(), subject: subject);
      },
      icon: const Icon(Icons.share),
      label: const Text("Share Acres"),
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
      label: const Text("Share Structures"),
      heroTag: "shareStructures",
    );
  }

  Widget? shareEverythingButton(estimate) {
    String subject = "Acres and Structures Order";
    return FloatingActionButton.extended(
      onPressed: () {
        Share.share(estimate.everythingOrderTextAndNotes(), subject: subject);
      },
      icon: const Icon(Icons.share),
      label: const Text("Share Everything"),
      heroTag: "shareEverything",
    );
  }

  Widget _spacerSizedBox(height) {
    return SizedBox(height: height, width: double.infinity);
  }

  DataColumn _dataColumn(name, color, fontSize) {
    return DataColumn(
        label: Text(name,
            style: TextStyle(
                color: color,
                fontSize: fontSize,
                fontWeight: FontWeight.bold)));
  }

  DataRow _estimateDataRow(name, nfesNum, quantity) {
    return DataRow(cells: [
      DataCell(Text(name)),
      DataCell(Text(nfesNum)),
      DataCell(Text(quantity.toString()))
    ]);
  }

  DataRow _notesDataRow(name) {
    return DataRow(cells: [
      DataCell(Text(name)),
      const DataCell(SizedBox(width: 140, child: Text('')))
    ]);
  }

  Widget _titleTextWidget(text, color, fontSize) {
    return Text(text,
        style: TextStyle(
            color: color, fontSize: fontSize, fontWeight: FontWeight.bold));
  }

  SizedBox _acresDataTable(estimate) {
    return SizedBox(
        width: double.infinity,
        child: DataTable(
          horizontalMargin: 15,
          dataRowHeight: 35,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.grey),
          border: TableBorder.all(color: const Color.fromARGB(255, 83, 83, 83)),
          columns: [
            _dataColumn("Name", Colors.black, 15.0),
            _dataColumn("NFES #", Colors.black, 15.0),
            _dataColumn("Quantity", Colors.black, 15.0)
          ],
          rows: [
            _estimateDataRow('Trunk Line &\n 1.5" Synthetic Hose', '001239',
                estimate.trunkLineLength),
            _estimateDataRow(
                '1" Lateral Line', '001238', estimate.latLineLength),
            _estimateDataRow('Toy Line', '001016', estimate.toyLineLength),
            _estimateDataRow(
                '1.5" Gated Wye', '000231', estimate.onePointFiveInchWye),
            _estimateDataRow(
                '1.5" Reducer', '000010', estimate.onePointFiveInchReducer),
            _estimateDataRow('1"-3/4" Reducers', '000733', estimate.fittings),
            _estimateDataRow('Forester Nozzles', '000024', estimate.fittings),
            _estimateDataRow('Toy Nozzles', '007387', estimate.fittings),
            _estimateDataRow('Toy Wye', '000904', estimate.fittings),
            _estimateDataRow('Fold-a-Tanks', '000664', estimate.foldaTanks),
            _estimateDataRow('Mark3 + Kits', '003870', estimate.mark3Kits),
            _estimateDataRow('Pump Mix (Cans)', 'N/A', estimate.pumpCans),
            _estimateDataRow('Water Pallets', 'N/A', estimate.waterPallets),
            _estimateDataRow(
                'Gatorade Pallets', 'N/A', estimate.gatoradePallets),
            _estimateDataRow('MRE Pallets', '001842', estimate.mrePallets),
            _estimateDataRow(
                'Port-a-Potties', 'N/A', estimate.portaPottiesPallets),
          ],
        ));
  }

  SizedBox _structuresDataTable(estimate) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        horizontalMargin: 15,
        dataRowHeight: 30,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.grey),
        border: TableBorder.all(color: const Color.fromARGB(255, 83, 83, 83)),
        columns: [
          _dataColumn("Name", Colors.black, 15.0),
          _dataColumn("NFES #", Colors.black, 15.0),
          _dataColumn("Quantity", Colors.black, 15.0)
        ],
        rows: [
          _estimateDataRow('Sprinkler Kits', '001048', estimate.sprinklerKits),
          _estimateDataRow('1.5" Hose', '001239', estimate.onePointFiveHose),
          _estimateDataRow('1.0" Hose', '001238', estimate.oneInchHose),
          _estimateDataRow(
              '1.5" Gated Wye', '000231', estimate.onePointFiveInchWye),
          _estimateDataRow('1.0" Gated Wye', '000259', estimate.oneInchWye),
          _estimateDataRow('1.0" - 1.5" Reducer', '000010',
              estimate.onePointFiveInchReducer),
          _estimateDataRow('KK Nozzles', '001081', estimate.kkNozzles),
          _estimateDataRow(
              'Mark3 Pumps & Kits', '003870', estimate.mark3Structures),
          _estimateDataRow('Fold-a-Tanks', '000664', estimate.foldaTanks),
          _estimateDataRow('Unleaded Gas', 'N/A', estimate.unleadedGas),
          _estimateDataRow('2-Cycle Oil (Quart)', 'N/A', estimate.twoCycleOil),
          _estimateDataRow(
              'Port-a-Potties', 'N/A', estimate.portaPottiesPallets),
          _estimateDataRow('Foam (Cans)', 'N/A', estimate.foam)
        ],
      ),
    );
  }

  SizedBox _notesDataTable(estimate) {
    return SizedBox(
        width: double.infinity,
        child: DataTable(
            dataRowHeight: 31,
            headingRowHeight: 10,
            horizontalMargin: 15,
            columns: [
              _dataColumn("", Colors.orange, 20.0),
              _dataColumn("", Colors.orange, 20.0)
            ],
            rows: [
              _notesDataRow('Incident Response Name'),
              _notesDataRow('POC Name'),
              _notesDataRow('POC Number'),
              _notesDataRow('Dispatch Center'),
              _notesDataRow('Drop Points'),
              _notesDataRow('Delivery Instructions'),
              _notesDataRow('Time/Date Needed'),
              _notesDataRow('Comments')
            ]));
  }
}
