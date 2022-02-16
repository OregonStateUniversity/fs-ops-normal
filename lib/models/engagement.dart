import 'estimate.dart';

class Engagement {
  final int? primaryKey;
  final int? active;
  final String? name;
  final String? timeStamp;
  final int? size;
  final String? shape;
  final String? type;
  final int? structures;
  final List<Estimate>? orders;

  Engagement(this.name, this.timeStamp, this.size, this.shape, this.type, this.structures,
      this.orders, this.active,
      [this.primaryKey]);

  @override
  String toString() {
    return '{ ${this.name}, ${this.timeStamp}, ${this.size}, ${this.shape}, ${this.type} ${this.structures} }';
  }
}
