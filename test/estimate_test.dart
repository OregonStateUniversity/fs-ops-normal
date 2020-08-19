import 'package:test/test.dart';
import 'package:hose_jockey/models/estimate.dart';

void main() {
  group('An Estimate', () {

    Estimate estimate;
    double acres = 42.0;

    setUp(() {
      estimate = Estimate(acres: acres);
    });

    test('has acres', () {
      expect(estimate.acres, equals(acres));
    });

  });

}
