import 'estimate.dart';

class Engagement {
  final int? primaryKey;
  final int? active;
  final String? name;
  final String? timeStamp;
  final int? size;
  final int? structures;
  final List<Estimate>? orders;

  Engagement(this.name, this.timeStamp, this.size, 
      this.structures, this.orders, this.active,
      [this.primaryKey]);

  @override
  String toString() {
    return '{ ${this.name}, ${this.timeStamp}, Size: ${this.size}, Structures: ${this.structures} }';
  }
}
