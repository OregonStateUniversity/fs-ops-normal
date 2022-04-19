import 'estimate.dart';

class Xengagement {
  final int? id;
  final String name;
  final bool active;
  final DateTime createdAt;
  final List<Estimate> estimates;

  Xengagement({this.id, required this.name, required this.createdAt, required this.estimates, required this.active});

  @override
  String toString() {
    return 'Engagement ${this.id}: ${this.name}, ${this.createdAt}';
  }

  get isSaved => id != null;

}
