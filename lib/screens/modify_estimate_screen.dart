import 'package:flutter/material.dart';
import 'estimate_screen.dart';
import '../models/estimate.dart';
import '../models/engagement.dart';
import '../persistence/database_manager.dart';
import '../persistence/estimate_dao.dart';
import '../persistence/estimate_dto.dart';

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
                  trunkLineRow(),
                  const SizedBox(height: 20.0),
                  latLineRow(),
                  const SizedBox(height: 20.0),
                  toyLineRow(),
                  const SizedBox(height: 20.0),
                  fittingsRow(),
                  const SizedBox(height: 20.0),
                  onePointFiveWyeRow(),
                  const SizedBox(height: 20.0),
                  onePointFiveRedRow(),
                  const SizedBox(height: 20.0),
                  foldaTanksRow(),
                  const SizedBox(height: 20.0),
                  mark3KitsRow(),
                  const SizedBox(height: 20.0),
                  pumpCansRow(),
                  const SizedBox(height: 20.0),
                  waterPalletsRow(),
                  const SizedBox(height: 20.0),
                  gatoradePalletsRow(),
                  const SizedBox(height: 20.0),
                  mrePalletsRow(),
                  const SizedBox(height: 20.0),
                  portaPottiesRow(),
                  const SizedBox(height: 20.0),
                  sprinklersRow(),
                  const SizedBox(height: 20.0),
                  onePointFiveHoseRow(),
                  const SizedBox(height: 20.0),
                  oneInchHoseRow(),
                  const SizedBox(height: 20.0),
                  oneInchWyeRow(),
                  const SizedBox(height: 20.0),
                  kkNozzlesRow(),
                  const SizedBox(height: 20.0),
                  mark3StructuresRow(),
                  const SizedBox(height: 20.0),
                  foldaTankStructuresRow(),
                  const SizedBox(height: 20.0),
                  unleadedGasRow(),
                  const SizedBox(height: 20.0),
                  twoCycleOilRow(),
                  const SizedBox(height: 20.0),
                  foamRow(),
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

  Widget trunkLineRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.trunkLineLength.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Trunk Line',
              suffixText: 'ft.',
            ),
            onSaved: (value) {
              orderField.trunkLineLength = int.parse(value!);
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

  Widget toyLineRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.toyLineLength.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Toy Line',
              suffixText: 'ft.',
            ),
            onSaved: (value) {
              orderField.toyLineLength = int.parse(value!);
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

  Widget fittingsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.fittings.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Various Fittings',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.fittingsField = int.parse(value!);
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

  Widget onePointFiveWyeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.onePointFiveInchWye.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '1.5" Wye',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.onePointFiveInchWye = int.parse(value!);
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

  Widget onePointFiveRedRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.onePointFiveInchReducer.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '1.5" Reducer',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.onePointFiveInchReducer = int.parse(value!);
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

  Widget foldaTanksRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.foldaTanks.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Fold-a-Tanks',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.foldaTanks = int.parse(value!);
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

  Widget mark3KitsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.mark3Kits.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Mark 3 + Kits',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.mark3Kits = int.parse(value!);
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

  Widget pumpCansRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.pumpCans.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Pump Cans',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.pumpCans = int.parse(value!);
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

  Widget waterPalletsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.waterPallets.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Water Pallets',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.waterPallets = int.parse(value!);
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

  Widget gatoradePalletsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.gatoradePallets.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Gatorade Pallets',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.gatoradePallets = int.parse(value!);
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

  Widget mrePalletsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.mrePallets.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'MRE Pallets',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.mrePallets = int.parse(value!);
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

  Widget portaPottiesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.portaPottiesPallets.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Port-a-Potties',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.portaPotties = int.parse(value!);
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

  Widget sprinklersRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.sprinklerKits.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Sprinker Kits',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.sprinklerKits = int.parse(value!);
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

  Widget onePointFiveHoseRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.onePointFiveHose.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '1.5" Hose',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.onePointFiveHose = int.parse(value!);
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

  Widget oneInchHoseRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.oneInchHose.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '1" Hose',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.oneInchHose = int.parse(value!);
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

  Widget oneInchWyeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.oneInchWye.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '1" Wye',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.oneInchWye = int.parse(value!);
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

  Widget kkNozzlesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.kkNozzles.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'KK Nozzles',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.kkNozzles = int.parse(value!);
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

  Widget mark3StructuresRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.mark3Structures.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Mark 3 Pump + Kits',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.mark3Structures = int.parse(value!);
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

  Widget foldaTankStructuresRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.foldaTankStructures.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Fold-a-Tanks Structures',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.foldaTankStructures = int.parse(value!);
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

  Widget unleadedGasRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.unleadedGas.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Unleaded Gas',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.unleadedGas = int.parse(value!);
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

  Widget twoCycleOilRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.twoCycleOil.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Two-Cycle Oil',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.twoCycleOil = int.parse(value!);
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

  Widget foamRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            initialValue: widget.estimate?.foam.toString(),
            style: const TextStyle(
              fontSize: 35.0,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Foam (Cans)',
              suffixText: 'ea.',
            ),
            onSaved: (value) {
              orderField.foam = int.parse(value!);
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
