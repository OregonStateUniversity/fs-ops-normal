import 'package:flutter/material.dart';
import 'estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../persistence/database_manager.dart';
import '../persistence/estimate_dao.dart';
import '../persistence/estimate_dto.dart';
import '../widgets/modify_item_row.dart';

class OrderFields {
  int? acres;
  int? trunkLineLength;
  int? latLineLength;
  int? toyLineLength;
  int? fittingsField;
  int? onePointFiveInchWye;
  int? onePointFiveInchReducer;
  int? foldaTanks;
  int? mark3Kits;
  int? pumpCans;
  int? waterPallets;
  int? gatoradePallets;
  int? mrePallets;
  int? portaPotties;
  int? sprinklerKits;
  int? onePointFiveHose;
  int? oneInchHose;
  int? oneInchWye;
  int? kkNozzles;
  int? mark3Structures;
  int? foldaTankStructures;
  int? unleadedGas;
  int? twoCycleOil;
  int? foam;

}

class ModifyEstimateScreen extends StatefulWidget {
  static const routeName = 'modifyEstimateScreen';

  final Estimate? estimate;
  final Engagement? engagement;
  const ModifyEstimateScreen({super.key, this.estimate, this.engagement});

  @override
  State<ModifyEstimateScreen> createState() => _ModifyEstimateScreenState();
}

class _ModifyEstimateScreenState extends State<ModifyEstimateScreen> {
  var formKey = GlobalKey<FormState>();
  OrderFields orderField = OrderFields();
  Estimate? est;

  @override
  Widget build(BuildContext context) {
    orderField.acres = widget.estimate?.acres;
    orderField.trunkLineLength = widget.estimate?.trunkLineLength;
    orderField.latLineLength = widget.estimate?.latLineLength;
    orderField.toyLineLength = widget.estimate?.toyLineLength;
    orderField.fittingsField = widget.estimate?.fittings;
    orderField.onePointFiveInchWye = widget.estimate?.onePointFiveInchWye;
    orderField.onePointFiveInchReducer =
        widget.estimate?.onePointFiveInchReducer;
    orderField.foldaTanks = widget.estimate?.foldaTanks;
    orderField.mark3Kits = widget.estimate?.mark3Kits;
    orderField.pumpCans = widget.estimate?.pumpCans;
    orderField.waterPallets = widget.estimate?.waterPallets;
    orderField.gatoradePallets = widget.estimate?.gatoradePallets;
    orderField.mrePallets = widget.estimate?.mrePallets;
    orderField.portaPotties = widget.estimate?.portaPottiesPallets;
    orderField.sprinklerKits = widget.estimate?.sprinklerKits;
    orderField.onePointFiveHose = widget.estimate?.onePointFiveHose;
    orderField.oneInchHose = widget.estimate?.oneInchHose;
    orderField.oneInchWye = widget.estimate?.oneInchWye;
    orderField.kkNozzles = widget.estimate?.kkNozzles;
    orderField.mark3Structures = widget.estimate?.mark3Structures;
    orderField.foldaTankStructures = widget.estimate?.foldaTankStructures;
    orderField.unleadedGas = widget.estimate?.unleadedGas;
    orderField.twoCycleOil = widget.estimate?.twoCycleOil;
    orderField.foam = widget.estimate?.foam;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Estimate Result'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30),
          child: Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ModifyItemRow(
                    initialValue: widget.estimate?.trunkLineLength.toString(), 
                    onOrderFieldChanged: (newTrunkLen) => orderField.trunkLineLength = newTrunkLen, 
                    labelText: 'Trunk Line',),
                  const SizedBox(height: 20.0),
                  latLineRow(),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.toyLineLength.toString(), 
                    onOrderFieldChanged: (newToyLine) => orderField.toyLineLength = newToyLine, 
                    labelText: 'Toy Line',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.fittings.toString(), 
                    onOrderFieldChanged: (newFittings) => orderField.fittingsField = newFittings, 
                    labelText: 'Various Fittings',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.onePointFiveInchWye.toString(), 
                    onOrderFieldChanged: (newOnePointFiveInchWye) => orderField.onePointFiveInchWye = newOnePointFiveInchWye, 
                    labelText: '1.5" Wye',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.onePointFiveInchReducer.toString(), 
                    onOrderFieldChanged: (newOnePointFiveInchRed) => orderField.onePointFiveInchReducer = newOnePointFiveInchRed, 
                    labelText: '1.5" Reducer',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.foldaTanks.toString(), 
                    onOrderFieldChanged: (newFoldaTanks) => orderField.foldaTanks = newFoldaTanks, 
                    labelText: 'Fold-a-Tanks',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.mark3Kits.toString(), 
                    onOrderFieldChanged: (newMark3Kits) => orderField.mark3Kits = newMark3Kits, 
                    labelText: 'Mark 3 + Kits',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.pumpCans.toString(), 
                    onOrderFieldChanged: (newPumpCans) => orderField.pumpCans = newPumpCans, 
                    labelText: 'Pump Cans',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.waterPallets.toString(), 
                    onOrderFieldChanged: (newWaterPallets) => orderField.waterPallets = newWaterPallets, 
                    labelText: 'Water Pallets',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.gatoradePallets.toString(), 
                    onOrderFieldChanged: (newGatoradePallets) => orderField.gatoradePallets = newGatoradePallets, 
                    labelText: 'Gatorade Pallets',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.mrePallets.toString(), 
                    onOrderFieldChanged: (newMrePallets) => orderField.mrePallets = newMrePallets, 
                    labelText: 'MRE Pallets',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.portaPottiesPallets.toString(), 
                    onOrderFieldChanged: (newPortaPotties) => orderField.portaPotties = newPortaPotties, 
                    labelText: 'Port-a-Potties',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.sprinklerKits.toString(), 
                    onOrderFieldChanged: (newSprinklerKits) => orderField.sprinklerKits = newSprinklerKits, 
                    labelText: 'Sprinkler Kits',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.onePointFiveHose.toString(), 
                    onOrderFieldChanged: (newOnePointFiveInchHose) => orderField.onePointFiveHose = newOnePointFiveInchHose, 
                    labelText: '1.5" Hose',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.oneInchHose.toString(), 
                    onOrderFieldChanged: (newOneInchHose) => orderField.oneInchHose = newOneInchHose, 
                    labelText: '1" Hose',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.oneInchWye.toString(), 
                    onOrderFieldChanged: (newOneInchWye) => orderField.oneInchWye = newOneInchWye, 
                    labelText: '1" Wye',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.kkNozzles.toString(), 
                    onOrderFieldChanged: (newKkNozzles) => orderField.kkNozzles = newKkNozzles, 
                    labelText: 'KK Nozzles',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.mark3Structures.toString(), 
                    onOrderFieldChanged: (newMark3Structures) => orderField.mark3Structures = newMark3Structures, 
                    labelText: 'Mark 3 Pump + Kits',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.foldaTankStructures.toString(), 
                    onOrderFieldChanged: (newFoldaTankStructures) => orderField.foldaTankStructures = newFoldaTankStructures, 
                    labelText: 'Fold-a-Tanks Structures',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.unleadedGas.toString(), 
                    onOrderFieldChanged: (newUnleadedGas) => orderField.unleadedGas = newUnleadedGas, 
                    labelText: 'Unleaded Gas',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.twoCycleOil.toString(), 
                    onOrderFieldChanged: (newOnePointFiveInchHose) => orderField.twoCycleOil = newOnePointFiveInchHose, 
                    labelText: 'Two-Cycle Oil',),
                  const SizedBox(height: 20.0),
                  ModifyItemRow(
                    initialValue: widget.estimate?.foam.toString(), 
                    onOrderFieldChanged: (newOnePointFiveInchHose) => orderField.foam = newOnePointFiveInchHose, 
                    labelText: 'Foam (Cans)',),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        // var newNum = checkNamingNumber();
                        var newNum = "";
                        var finalEstimate = Estimate.finalEstimate(
                            newNum,
                            orderField.acres,
                            widget.estimate?.structures,
                            widget.estimate?.timeStamp,
                            widget.estimate?.perimeter,
                            orderField.trunkLineLength,
                            orderField.latLineLength,
                            orderField.toyLineLength,
                            orderField.fittingsField,
                            orderField.onePointFiveInchWye,
                            orderField.onePointFiveInchReducer,
                            orderField.foldaTanks,
                            orderField.mark3Kits,
                            orderField.pumpCans,
                            orderField.waterPallets,
                            orderField.gatoradePallets,
                            orderField.mrePallets,
                            orderField.portaPotties,
                            orderField.sprinklerKits,
                            orderField.onePointFiveHose,
                            orderField.oneInchHose,
                            orderField.oneInchWye,
                            orderField.kkNozzles,
                            orderField.mark3Structures,
                            orderField.foldaTankStructures,
                            orderField.unleadedGas,
                            orderField.twoCycleOil,
                            orderField.foam);
                        finalEstimate.createdAt = DateTime.now();
                        EstimateDAO.save(
                            databaseManager: DatabaseManager.getInstance(),
                            dto: EstimateDTO.fromEngagementEstimate(
                                engagement: widget.engagement!,
                                estimate: finalEstimate));
                        Navigator.pushNamed(context, EstimateScreen.routeName,
                            arguments: EstimateScreenArgs(true, finalEstimate));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                    ),
                    child: const Text('Save',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Widget latLineRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.latLineLength.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Lat Line',
              suffixText: 'ft.',
            ),
            onChanged: (value) {
              orderField.fittingsField = int.parse(value) ~/ 100;
            },
            onSaved: (value) {
              orderField.latLineLength = int.parse(value!);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Needs some value";
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }
}
