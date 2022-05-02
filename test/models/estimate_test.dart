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
      estimate = new Estimate.jsonConvF(1, 1, 2, "time", 1200, 600, 300, 6);

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
      Estimate estimate = new Estimate(acres: 1);
      // estimate.acres = 1;
      var expected =
          "{name: -1, timeStamp: null, acres: 1, structures: 0, trunkLineLength: 1200, latLineLength: 600, toyLineLength: 300, fittings: 6}";

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
      Estimate estimate = new Estimate(acres: 1);

      //Assert
      expect(estimate.acres, equals(1));
      expect(estimate.trunkLineLength, equals(1200));
      expect(estimate.latLineLength, equals(600));
      expect(estimate.toyLineLength, equals(300));
      expect(estimate.fittings, equals(6));
    });

    test('toCopyString that is 1-9 acres', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 1);
      var expected = "Trunk Line: 1200 ft.\n"
          "Lat Line: 600 ft.\n"
          "Toy Hose: 300 ft.\n\n"
          "1.5\" Gated Wye: 6\n"
          "1.5\" Reducers: 6\n"
          "1\"-3/4\" Reducers: 6\n"
          "Forester Nozzles: 6\n"
          "Toy Nozzles: 6\n"
          "Toy Wye: 6\n\n"
          "Folda-tank: 0\n"
          "Mark 3 + Kits: 0\n"
          "Pump Mix (Cans): 0\n\n"
          "Water (Pallets): 0\n"
          "Gatorade (Pallets): 0\n"
          "MRE (Pallets): 0\n"
          "Port-a-Potties: 0\n\n";

      //Act
      var actual = estimate.flatFireOrderText();

      //Assert
      expect(actual, equals(expected));
    });

    test('toCopyString that is 10-19 acres', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 10);
      var expected = "Trunk Line: 3000 ft.\n"
          "Lat Line: 1500 ft.\n"
          "Toy Hose: 750 ft.\n\n"
          "1.5\" Gated Wye: 15\n"
          "1.5\" Reducers: 15\n"
          "1\"-3/4\" Reducers: 15\n"
          "Forester Nozzles: 15\n"
          "Toy Nozzles: 15\n"
          "Toy Wye: 15\n\n"
          "Folda-tank: 2\n"
          "Mark 3 + Kits: 1\n"
          "Pump Mix (Cans): 6\n\n"
          "Water (Pallets): 0\n"
          "Gatorade (Pallets): 0\n"
          "MRE (Pallets): 0\n"
          "Port-a-Potties: 0\n\n";

      //Act
      var actual = estimate.flatFireOrderText();

      //Assert
      expect(actual, equals(expected));
    });

    test('toCopyString that is 20+ acres', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 20);
      var expected = "Trunk Line: 5000 ft.\n"
          "Lat Line: 2500 ft.\n"
          "Toy Hose: 1250 ft.\n\n"
          "1.5\" Gated Wye: 25\n"
          "1.5\" Reducers: 25\n"
          "1\"-3/4\" Reducers: 25\n"
          "Forester Nozzles: 25\n"
          "Toy Nozzles: 25\n"
          "Toy Wye: 25\n\n"
          "Folda-tank: 4\n"
          "Mark 3 + Kits: 2\n"
          "Pump Mix (Cans): 12\n\n"
          "Water (Pallets): 1\n"
          "Gatorade (Pallets): 1\n"
          "MRE (Pallets): 1\n"
          "Port-a-Potties: 2\n\n";

      //Act
      var actual = estimate.flatFireOrderText();

      //Assert
      expect(actual, equals(expected));
    });
  });

  group('Estimate default methods', () {
    test('Defualt Trunk Line Length - Acres: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0);
      var expected = 1000;

      //Act
      var actual = estimate.defaultTrunkLineLength();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Trunk Line Length - Acres: 10', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 10);
      var expected = 3000;

      //Act
      var actual = estimate.defaultTrunkLineLength();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Lat Line Length - Acres: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0);
      var expected = 500;

      //Act
      var actual = estimate.defaultLatLineLength();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Lat Line Length - Acres: 10', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 10);
      var expected = 1500;

      //Act
      var actual = estimate.defaultLatLineLength();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Toy Line Length - Acres: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0);
      var expected = 250;

      //Act
      var actual = estimate.defaultToyLineLength();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Toy Line Length - Acres: 10', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 10);
      var expected = 750;

      //Act
      var actual = estimate.defaultToyLineLength();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Fittings - Acres: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0);
      var expected = 5;

      //Act
      var actual = estimate.defaultFittings();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Fittings - Acres: 10', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 10);
      var expected = 15;

      //Act
      var actual = estimate.defaultFittings();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt FoldaTanks - Acres: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultFoldaTanks();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt FoldaTanks - Acres: 10', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 10);
      var expected = 2;

      //Act
      var actual = estimate.defaultFoldaTanks();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3Pumps - Acres: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultMark3PumpsAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3Pumps - Acres: 10', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 10);
      var expected = 1;

      //Act
      var actual = estimate.defaultMark3PumpsAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3Kits - Acres: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.calculateMark3KitsAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3Kits - Acres: 10', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 10);
      var expected = 1;

      //Act
      var actual = estimate.calculateMark3KitsAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3PumpMix - Acres: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultPumpMixCansAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3PumpMix - Acres: 10', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 10);
      var expected = 6;

      //Act
      var actual = estimate.defaultPumpMixCansAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt WaterPallets - Acres: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultWaterPallets();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt WaterPallets - Acres: 20', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 20);
      var expected = 1;

      //Act
      var actual = estimate.defaultWaterPallets();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt GatoradePallets - Acres: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultGatoradePallets();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt GatoradePallets - Acres: 20', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 20);
      var expected = 1;

      //Act
      var actual = estimate.defaultGatoradePallets();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt MREPallets - Acres: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultMrePallets();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt MREPallets - Acres: 20', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 20);
      var expected = 1;

      //Act
      var actual = estimate.defaultMrePallets();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt PortaPotties - Acres: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultPortaPottiesAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt PortaPotties - Acres: 20', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 20);
      var expected = 2;

      //Act
      var actual = estimate.defaultPortaPottiesAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Sprinklers - Structures: 0', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0, structures: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultSprinklers();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Sprinklers - Structures: 0 < x < 10 ', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0, structures: 5);
      var expected = 10;

      //Act
      var actual = estimate.defaultSprinklers();

      //Assert
      expect(actual, equals(expected));
    });


    test('Defualt Sprinklers - Structures: 10 < x < 40 ', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0, structures: 20);
      var expected = 40;

      //Act
      var actual = estimate.defaultSprinklers();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Sprinklers - Structures: x > 40 ', () {
      //Arrange
      Estimate estimate = new Estimate(acres: 0, structures: 50);
      var expected = 50;

      //Act
      var actual = estimate.defaultSprinklers();

      //Assert
      expect(actual, equals(expected));
    });


  });
}
