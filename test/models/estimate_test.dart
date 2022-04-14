import 'package:test/test.dart';
import 'package:hose_jockey/models/estimate.dart';

void main() {
  group('An Estimate', () {
    test('using finalEstimate named constructor', () {
      //Arrange
      Estimate estimate;

      //Act
      estimate = new Estimate.finalEstimate(1, 1, "time", 0, 1200, 600, 300, 6);

      //Assert
      expect(estimate.name, equals(1));
      expect(estimate.acres, equals(1));
      expect(estimate.trunkLineLength, equals(1200));
      expect(estimate.latLineLength, equals(600));
      expect(estimate.toyLineLength, equals(300));
      expect(estimate.fittings, equals(6));
    });

    test('using jsonConvF named constructor', () {
      //Arrange
      Estimate estimate;

      //Act
      estimate = new Estimate.jsonConvF(
          1, 1, "Square", "Timber", 2, "time", 1200, 600, 300, 6);

      //Assert
      expect(estimate.name, equals(1));
      expect(estimate.acres, equals(1));
      expect(estimate.trunkLineLength, equals(1200));
      expect(estimate.latLineLength, equals(600));
      expect(estimate.toyLineLength, equals(300));
      expect(estimate.fittings, equals(6));
    });

    test('toJson', () {
      //Arrange
      Estimate estimate = new Estimate();
      estimate.acres = 1;
      var expected =
          "{name: -1, acres: 1, timeStamp: null, shape: null, type: null, structures: 0, trunkLineLength: 1200, latLineLength: 600, toyLineLength: 300, fittings: 6}";

      //Act
      var estimateJson = estimate.toJson().toString();

      //Assert
      expect(estimateJson, equals(expected));
    });

    test('fromJson', () {
      //Arrange
      Estimate estimate = new Estimate();
      estimate.acres = 1;
      var estimateToJson = estimate.toJson();

      //Act
      var estimateFromJson = Estimate.fromJson(estimateToJson);

      //Assert
      expect(estimate.name, equals(estimateFromJson.name));
      expect(estimate.acres, equals(estimateFromJson.acres));
      expect(
          estimate.trunkLineLength, equals(estimateFromJson.trunkLineLength));
      expect(estimate.latLineLength, equals(estimateFromJson.latLineLength));
      expect(estimate.toyLineLength, equals(estimateFromJson.toyLineLength));
      expect(estimate.fittings, equals(estimateFromJson.fittings));
    });

    test('has initial calculations', () {
      //Arrange
      Estimate estimate = new Estimate();
      estimate.acres = 1;

      //Assert
      expect(estimate.acres, equals(1));
      expect(estimate.trunkLineLength, equals(1200));
      expect(estimate.latLineLength, equals(600));
      expect(estimate.toyLineLength, equals(300));
      expect(estimate.fittings, equals(6));
    });

    test('toCopyString that is 1-9 acres', () {
      //Arrange
      Estimate estimate = new Estimate();
      estimate.acres = 1;
      var expected = "Trunk Line: 1200 ft.\n"
          "Lat Line: 600 ft.\n"
          "Toy Hose: 300 ft.\n\n"
          "1.5\" Gated Wye: 6\n"
          "1.5\" Reducers: 6\n"
          "1\"-3/4\" Reducers: 6\n"
          "Forester Nozzles: 6\n"
          "Toy Nozzles: 6\n"
          "Toy Wye: 6\n\n";

      //Act
      var actual = estimate.flatFireOrderText();

      //Assert
      expect(actual, equals(expected));
    });

    test('toCopyString that is 10-19 acres', () {
      //Arrange
      Estimate estimate = new Estimate();
      int acres = 10;
      estimate.acres = acres;
      var expected = "Trunk Line: 3000 ft.\n"
          "Lat Line: 1500 ft.\n"
          "Toy Hose: 750 ft.\n\n"
          "1.5\" Gated Wye: 15\n"
          "1.5\" Reducers: 15\n"
          "1\"-3/4\" Reducers: 15\n"
          "Forester Nozzles: 15\n"
          "Toy Nozzles: 15\n"
          "Toy Wye: 15\n\n"
          "Folda-tank: ${acres ~/ 5}\n"
          "Mark 3 + Kits: ${acres ~/ 5}\n"
          "Pump Mix (Gallons): ${((acres ~/ 5) ~/ 2) * 3}\n\n";

      //Act
      var actual = estimate.flatFireOrderText();

      //Assert
      expect(actual, equals(expected));
    });

    test('toCopyString that is 20+ acres', () {
      //Arrange
      Estimate estimate = new Estimate();
      int acres = 20;
      estimate.acres = acres;
      var expected = "Trunk Line: 5000 ft.\n"
          "Lat Line: 2500 ft.\n"
          "Toy Hose: 1250 ft.\n\n"
          "1.5\" Gated Wye: 25\n"
          "1.5\" Reducers: 25\n"
          "1\"-3/4\" Reducers: 25\n"
          "Forester Nozzles: 25\n"
          "Toy Nozzles: 25\n"
          "Toy Wye: 25\n\n"
          "Folda-tank: ${acres ~/ 5}\n"
          "Mark 3 + Kits: ${acres ~/ 10 * 6}\n"
          "Pump Mix (Gallons): ${((acres ~/ 5) ~/ 2) * 3}\n\n"
          "Water (Pallets): ${acres ~/ 20}\n"
          "Gatorade (Pallets): ${acres ~/ 20}\n"
          "MRE (Pallets): ${acres ~/ 20}\n"
          "Port-a-Potties: ${acres ~/ 2}\n\n";

      //Act
      var actual = estimate.flatFireOrderText();

      //Assert
      expect(actual, equals(expected));
    });
  });
}
