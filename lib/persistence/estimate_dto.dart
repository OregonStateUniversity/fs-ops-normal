import '../models/engagement.dart';
import '../models/estimate.dart';

class EstimateDTO {
  final int? engagementId;
  final String name;
  final DateTime createdAt;
  final int acres;
  final int structures;
  final int truckLineLength;
  final int latLineLength;
  final int toyLineLength;
  final int fittings;
  final int onePointFiveInchWye;
  final int onePointFiveInchReducer;
  final int foldaTanks;
  final int mark3Kits;
  final int pumpCans;
  final int waterPallets;
  final int gatoradePallets;
  final int mrePallets;
  final int portaPottiesPallets;
  final int sprinklerKits;

  EstimateDTO(
      {this.engagementId,
      required this.name,
      required this.createdAt,
      required this.acres,
      required this.structures,
      required this.truckLineLength,
      required this.latLineLength,
      required this.toyLineLength,
      required this.fittings,
      required this.onePointFiveInchWye,
      required this.onePointFiveInchReducer,
      required this.foldaTanks,
      required this.mark3Kits,
      required this.pumpCans,
      required this.waterPallets,
      required this.gatoradePallets,
      required this.mrePallets,
      required this.portaPottiesPallets,
      required this.sprinklerKits});

  EstimateDTO.fromEngagementEstimate(
      {required Engagement engagement, required Estimate estimate})
      : engagementId = engagement.id,
        name = estimate.name.toString(),
        createdAt = estimate.createdAt!,
        acres = estimate.acres!,
        structures = estimate.structures!,
        truckLineLength = estimate.toyLineLength!,
        latLineLength = estimate.latLineLength!,
        toyLineLength = estimate.toyLineLength!,
        fittings = estimate.fittings!,
        onePointFiveInchReducer = estimate.onePointFiveInchReducer!,
        onePointFiveInchWye = estimate.onePointFiveInchWye!,
        foldaTanks = estimate.foldaTanks!,
        mark3Kits = estimate.mark3Kits!,
        pumpCans = estimate.pumpCans!,
        waterPallets = estimate.waterPallets!,
        gatoradePallets = estimate.gatoradePallets!,
        mrePallets = estimate.mrePallets!,
        portaPottiesPallets = estimate.portaPottiesPallets!,
        sprinklerKits = estimate.sprinklerKits!;

  @override
  String toString() =>
      'EngagementId: $engagementId, Name: $name, Created At: $createdAt, acres: $acres, Structures: $structures, Truck Line: $truckLineLength, Lat Line: $latLineLength, Toy Line: $toyLineLength, Fittings: $fittings, 1.5 Inch Wye: $onePointFiveInchWye, 1.5 Inch Reducer: $onePointFiveInchReducer, Folda-Tanks: $foldaTanks, Mark3 Kits: $mark3Kits, Pump Mix Cans: $pumpCans, Water Pallets: $waterPallets, Gatorade Pallets: $gatoradePallets, MRE Pallets: $mrePallets, Porta-Potty Pallets: $portaPottiesPallets, Sprinkler Kits: $sprinklerKits';
}
