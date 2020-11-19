import 'estimate.dart';

class Engagement {
  String name;
  String fireTimeStamp;
  int size;
  List<Estimate> orders;

  Engagement(this.name, this.fireTimeStamp, this.size, this.orders);

  @override
  String toString() {
    return '{ ${this.name}, ${this.fireTimeStamp}, ${this.size} }';
  }
}