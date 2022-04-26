import 'estimate.dart';

class Engagement {
  final int? id;
  final String name;
  final DateTime createdAt;
  final bool active;
  final List<Estimate> estimates;

  Engagement({this.id, required this.name, required this.createdAt, required this.estimates, required this.active});

  @override
  String toString() {
    return 'Engagement ${this.id}: ${this.name}, ${this.createdAt}';
  }

  get isSaved => id != null;

  Engagement.fromMap({required Map map}) :
    id = map['id'],
    name = map['name'],
    createdAt = DateTime.parse(map['createdAt']),
    active = map['active'] == 1,
    estimates = [];

}
