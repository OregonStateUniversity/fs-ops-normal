import 'package:test/test.dart';
import 'package:ops_normal/models/estimate.dart';

void main() {
  group('An Estimate', () {
    test('using finalEstimate named constructor', () {
      //Arrange
      Estimate estimate;

      //Act
      estimate = Estimate.finalEstimate(
          "name",
          1,
          0,
          "time",
          1200,
          600,
          300,
          6,
          25,
          63,
          45,
          25,
          41,
          300,
          84,
          91,
          62,
          31,
          52,
          45,
          78,
          82,
          39,
          42,
          64,
          12,
          15);

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
      estimate = Estimate.jsonConvF(
          "name",
          1,
          2,
          "time",
          1200,
          600,
          300,
          6,
          30,
          65,
          7,
          12,
          23,
          45,
          12,
          67,
          11,
          10,
          4,
          13,
          21,
          22,
          23,
          245,
          25,
          36,
          24);

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
      Estimate estimate = Estimate(acres: 1);
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
      Estimate estimate = Estimate();
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

    test('has initial acre calculations', () {
      //Arrange
      Estimate estimate = Estimate(acres: 1);

      //Assert
      expect(estimate.acres, equals(1));
      expect(estimate.trunkLineLength, equals(1200));
      expect(estimate.latLineLength, equals(600));
      expect(estimate.toyLineLength, equals(300));
      expect(estimate.fittings, equals(6));
    });

    test('has initial structure calculations', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 1);

      //Assert
      expect(estimate.acres, equals(0));
      expect(estimate.trunkLineLength, equals(1000));
      expect(estimate.latLineLength, equals(500));
      expect(estimate.toyLineLength, equals(250));
      expect(estimate.fittings, equals(5));
    });

    test('flat fire that is 1-9 acres', () {
      //Arrange
      Estimate estimate = Estimate(acres: 1);
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

    test('flat fire  that is 10-19 acres', () {
      //Arrange
      Estimate estimate = Estimate(acres: 10);
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

    test('flat fire  that is 20+ acres', () {
      //Arrange
      Estimate estimate = Estimate(acres: 20);
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
      Estimate estimate = Estimate(acres: 0);
      var expected = 1000;

      //Act
      var actual = estimate.defaultTrunkLineLength();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Trunk Line Length - Acres: 10', () {
      //Arrange
      Estimate estimate = Estimate(acres: 10);
      var expected = 3000;

      //Act
      var actual = estimate.defaultTrunkLineLength();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Lat Line Length - Acres: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0);
      var expected = 500;

      //Act
      var actual = estimate.defaultLatLineLength();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Lat Line Length - Acres: 10', () {
      //Arrange
      Estimate estimate = Estimate(acres: 10);
      var expected = 1500;

      //Act
      var actual = estimate.defaultLatLineLength();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Toy Line Length - Acres: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0);
      var expected = 250;

      //Act
      var actual = estimate.defaultToyLineLength();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Toy Line Length - Acres: 10', () {
      //Arrange
      Estimate estimate = Estimate(acres: 10);
      var expected = 750;

      //Act
      var actual = estimate.defaultToyLineLength();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Fittings - Acres: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0);
      var expected = 5;

      //Act
      var actual = estimate.defaultFittings();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Fittings - Acres: 10', () {
      //Arrange
      Estimate estimate = Estimate(acres: 10);
      var expected = 15;

      //Act
      var actual = estimate.defaultFittings();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt FoldaTanks - Acres: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultFoldaTanksAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt FoldaTanks - Acres: 10', () {
      //Arrange
      Estimate estimate = Estimate(acres: 10);
      var expected = 2;

      //Act
      var actual = estimate.defaultFoldaTanksAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3Pumps - Acres: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultMark3PumpsAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3Pumps - Acres: 10', () {
      //Arrange
      Estimate estimate = Estimate(acres: 10);
      var expected = 1;

      //Act
      var actual = estimate.defaultMark3PumpsAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3Kits - Acres: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.calculateMark3KitsAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3Kits - Acres: 10', () {
      //Arrange
      Estimate estimate = Estimate(acres: 10);
      var expected = 1;

      //Act
      var actual = estimate.calculateMark3KitsAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3PumpMix - Acres: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultPumpMixCansAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3PumpMix - Acres: 10', () {
      //Arrange
      Estimate estimate = Estimate(acres: 10);
      var expected = 6;

      //Act
      var actual = estimate.defaultPumpMixCansAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt WaterPallets - Acres: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultWaterPallets();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt WaterPallets - Acres: 20', () {
      //Arrange
      Estimate estimate = Estimate(acres: 20);
      var expected = 1;

      //Act
      var actual = estimate.defaultWaterPallets();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt GatoradePallets - Acres: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultGatoradePallets();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt GatoradePallets - Acres: 20', () {
      //Arrange
      Estimate estimate = Estimate(acres: 20);
      var expected = 1;

      //Act
      var actual = estimate.defaultGatoradePallets();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt MREPallets - Acres: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultMrePallets();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt MREPallets - Acres: 20', () {
      //Arrange
      Estimate estimate = Estimate(acres: 20);
      var expected = 1;

      //Act
      var actual = estimate.defaultMrePallets();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt PortaPotties - Acres: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultPortaPottiesAcres();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt PortaPotties - Acres: 20', () {
      //Arrange
      Estimate estimate = Estimate(acres: 20);
      var expected = 2;

      //Act
      var actual = estimate.defaultPortaPottiesAcres();

      //Assert
      expect(actual, equals(expected));
    });

    // STRUCTURE TESTS BELOW

    test('Defualt Sprinklers - Structures: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultSprinklerKits();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Sprinklers - Structures: 0 < x < 10 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 5);
      var expected = 10;

      //Act
      var actual = estimate.defaultSprinklerKits();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Sprinklers - Structures: 10 < x < 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 20);
      var expected = 40;

      //Act
      var actual = estimate.defaultSprinklerKits();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Sprinklers - Structures: x > 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 50);
      var expected = 50;

      //Act
      var actual = estimate.defaultSprinklerKits();

      //Assert
      expect(actual, equals(expected));
    });

    // OnePointFive

    test('Defualt OnePointFive Hose - Structures: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultOnePointFiveHose();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OnePointFive Hose - Structures: 0 < x < 10 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 5);
      var expected = 3000;

      //Act
      var actual = estimate.defaultOnePointFiveHose();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OnePointFive Hose - Structures: 10 < x < 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 20);
      var expected = 5000;

      //Act
      var actual = estimate.defaultOnePointFiveHose();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OnePointFive Hose - Structures: x > 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 50);
      var expected = 7000;

      //Act
      var actual = estimate.defaultOnePointFiveHose();

      //Assert
      expect(actual, equals(expected));
    });

    // One Inch Hose

    test('Defualt OneInch Hose - Structures: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultOneInchHose();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OneInch Hose - Structures: 0 < x < 10 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 5);
      var expected = 20;

      //Act
      var actual = estimate.defaultOneInchHose();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OneInch Hose - Structures: 10 < x < 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 20);
      var expected = 35;

      //Act
      var actual = estimate.defaultOneInchHose();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OneInch Hose - Structures: x > 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 50);
      var expected = 50;

      //Act
      var actual = estimate.defaultOneInchHose();

      //Assert
      expect(actual, equals(expected));
    });

    // One Point Five Wye

    test('Defualt OnePointFive Wye - Structures: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultOnePointFiveWye();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OnePointFive Wye - Structures: 0 < x < 10 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 5);
      var expected = 10;

      //Act
      var actual = estimate.defaultOnePointFiveWye();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OnePointFive Wye - Structures: 10 < x < 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 20);
      var expected = 40;

      //Act
      var actual = estimate.defaultOnePointFiveWye();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OnePointFive Wye - Structures: x > 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 50);
      var expected = 50;

      //Act
      var actual = estimate.defaultOnePointFiveWye();

      //Assert
      expect(actual, equals(expected));
    });

    // One Inch Wye

    test('Defualt OneInch Wye  - Structures: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultOneInchWye();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OneInch Wye  - Structures: 0 < x < 10 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 5);
      var expected = 20;

      //Act
      var actual = estimate.defaultOneInchWye();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OneInch Wye  - Structures: 10 < x < 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 20);
      var expected = 40;

      //Act
      var actual = estimate.defaultOneInchWye();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OneInch Wye  - Structures: x > 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 50);
      var expected = 50;

      //Act
      var actual = estimate.defaultOneInchWye();

      //Assert
      expect(actual, equals(expected));
    });

    // OnePointFiveToOneInchReducer

    test('Defualt OnePointFiveToOneInchReducer - Structures: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultOnePointFiveToOneInchReducer();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OnePointFiveToOneInchReducer - Structures: 0 < x < 10 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 5);
      var expected = 20;

      //Act
      var actual = estimate.defaultOnePointFiveToOneInchReducer();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OnePointFiveToOneInchReducer - Structures: 10 < x < 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 20);
      var expected = 20;

      //Act
      var actual = estimate.defaultOnePointFiveToOneInchReducer();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt OnePointFiveToOneInchReducer - Structures: x > 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 50);
      var expected = 30;

      //Act
      var actual = estimate.defaultOnePointFiveToOneInchReducer();

      //Assert
      expect(actual, equals(expected));
    });

    // KK Nozzles

    test('Defualt KK Nozzles   - Structures: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultKkNozzles();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt KK Nozzles  - Structures: 0 < x < 10 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 5);
      var expected = 20;

      //Act
      var actual = estimate.defaultKkNozzles();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt KK Nozzles  - Structures: 10 < x < 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 20);
      var expected = 20;

      //Act
      var actual = estimate.defaultKkNozzles();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt KK Nozzles  - Structures: x > 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 50);
      var expected = 30;

      //Act
      var actual = estimate.defaultKkNozzles();

      //Assert
      expect(actual, equals(expected));
    });

    // Mark 3 Structures

    test('Defualt Mark3Structures - Structures: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultMark3Structures();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3Structures - Structures: 0 < x < 10 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 5);
      var expected = 3;

      //Act
      var actual = estimate.defaultMark3Structures();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3Structures - Structures: 10 < x < 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 20);
      var expected = 6;

      //Act
      var actual = estimate.defaultMark3Structures();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Mark3Structures - Structures: x > 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 50);
      var expected = 10;

      //Act
      var actual = estimate.defaultMark3Structures();

      //Assert
      expect(actual, equals(expected));
    });

    // Unleaded Gas
    group('defaultUnleadedGas', () {
      test('Defualt Unleaded Gas - Structures: x < 10', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultUnleadedGas(), equals(30));
      });

      test('Defualt Unleaded Gas - Structures: 10 < x < 40', () {
        Estimate estimate = Estimate(acres: 0, structures: 20);
        expect(estimate.defaultUnleadedGas(), equals(90));
      });

      test('Defualt Unleaded Gas - Structures: x > 40', () {
        Estimate estimate = Estimate(acres: 0, structures: 50);
        expect(estimate.defaultUnleadedGas(), equals(300));
      });
    });

    // Two Cycle Oil

    group('defaultTwoCycleOil', () {
      test('0 when there are no structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 0);
        expect(estimate.defaultTwoCycleOil(), equals(0));
      });
      test('6 when there is less than 10 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultTwoCycleOil(), equals(6));
      });
      test('18 when there is less than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 30);
        expect(estimate.defaultTwoCycleOil(), equals(6));
      });
      test('18 when there is exactly 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 40);
        expect(estimate.defaultTwoCycleOil(), equals(18));
      });
      test('60 when there is more than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 50);
        expect(estimate.defaultTwoCycleOil(), equals(60));
      });
    });

    // Porta Potties Structure

    test('Defualt Porta Potties Structure - Structures: 0', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 0);
      var expected = 0;

      //Act
      var actual = estimate.defaultPortaPottiesStructures();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Porta Potties Structure - Structures: 0 < x < 10 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 5);
      var expected = 5;

      //Act
      var actual = estimate.defaultPortaPottiesStructures();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Porta Potties Structure - Structures: 10 < x < 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 20);
      var expected = 6;

      //Act
      var actual = estimate.defaultPortaPottiesStructures();

      //Assert
      expect(actual, equals(expected));
    });

    test('Defualt Porta Potties Structure - Structures: x > 40 ', () {
      //Arrange
      Estimate estimate = Estimate(acres: 0, structures: 50);
      var expected = 10;

      //Act
      var actual = estimate.defaultPortaPottiesStructures();

      //Assert
      expect(actual, equals(expected));
    });

    group("defaultFoldATankStructures", () {
      test('Defualt defaultFoldATankStructures - Structure: x = 0 ', () {
        //Arrange
        Estimate estimate = Estimate(acres: 0, structures: 0);
        var expected = 0;
        //Act
        var actual = estimate.defaultFoldATankStructures();
        //Assert
        expect(actual, equals(expected));
      });
      test('Defualt defaultFoldATankStructures - Structure: x > 0 ', () {
        //Arrange
        Estimate estimate = Estimate(acres: 0, structures: 20);
        var expected = 16;
        //Act
        var actual = estimate.defaultFoldATankStructures();
        //Assert
        expect(actual, equals(expected));
      });
    });
    group('defaultFoam', () {
      test('0 when there are no structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 0);
        expect(estimate.defaultFoam(), equals(0));
      });
      test('5 when there are structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 10);
        expect(estimate.defaultFoam(), equals(5));
      });
    });
  });
}
