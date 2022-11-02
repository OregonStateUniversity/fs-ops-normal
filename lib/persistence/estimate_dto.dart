import '../models/engagement.dart';
import '../models/estimate.dart';

class EstimateDTO {

  final int? engagementId;
  final String name;
  final DateTime createdAt;
  final int acres;
  final int structures;

  EstimateDTO({this.engagementId, required this.name, required this.createdAt, required this.acres, required this.structures});

  EstimateDTO.fromEngagementEstimate({required Engagement engagement, required Estimate estimate}) :
    engagementId = engagement.id,
    name = estimate.name.toString(),
    createdAt = estimate.createdAt!,
    acres = estimate.acres!,
    structures = estimate.structures!;

  @override
  String toString() =>
    'EngagementId: $engagementId, Name: $name, Created At: $createdAt, acres: $acres, Structures: $structures';

}
