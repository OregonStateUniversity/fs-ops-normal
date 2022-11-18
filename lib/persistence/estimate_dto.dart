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

  EstimateDTO(
      {this.engagementId,
      required this.name,
      required this.createdAt,
      required this.acres,
      required this.structures,
      required this.truckLineLength,
      required this.latLineLength,
      required this.toyLineLength,
      required this.fittings});

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
        fittings = estimate.fittings!;

  @override
  String toString() =>
      'EngagementId: $engagementId, Name: $name, Created At: $createdAt, acres: $acres, Structures: $structures, Truck Line: $truckLineLength, Lat Line: $latLineLength, Toy Line: $toyLineLength, Fittings: $fittings';
}
