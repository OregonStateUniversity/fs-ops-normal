import 'estimate.dart';

class Engagement {
  int primaryKey;
  int active;
  String name;
  String fireTimeStamp;
  int size;
  List<Estimate> orders;

  Engagement(this.name, this.fireTimeStamp, this.size, this.orders, [this.active, this.primaryKey]);

  @override
  String toString() {
    return '{ ${this.name}, ${this.fireTimeStamp}, ${this.size} }';
  }
}