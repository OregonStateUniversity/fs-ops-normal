import 'estimate.dart';

class Xengagement {
  final int? id;
  final String name;
  final bool active;
  final DateTime timeStamp;
  final List<Estimate> estimates;

  Xengagement({this.id, required this.name, required this.timeStamp, required this.estimates, required this.active});

  @override
  String toString() {
    return 'Engagement ${this.id}: ${this.name}, ${this.timeStamp}';
  }

  get isSaved => id != null;

}
