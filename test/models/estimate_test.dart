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
  });

  group('Estimate default methods', () {
    group('defaultTrunkLineLength', () {
      test('1000 if acres is 0', () {
        Estimate estimate = Estimate(acres: 0);
        expect(1000, estimate.defaultTrunkLineLength());
      });
      test('3000 if acres is 10 (1000 base + 200 per acre)', () {
        Estimate estimate = Estimate(acres: 10);
        expect(3000, estimate.defaultTrunkLineLength());
      });
    });

    group('defaultLatLineLength', () {
      test('500 if acres is 0', () {
        Estimate estimate = Estimate(acres: 0);
        expect(500, estimate.defaultLatLineLength());
      });

      test('1500 if acres is 10 (500 base + 100 per acre)', () {
        Estimate estimate = Estimate(acres: 10);
        expect(1500, estimate.defaultLatLineLength());
      });
    });

    group('defaultToyLineLength', () {
      test('250 if acres is 0', () {
        Estimate estimate = Estimate(acres: 0);
        expect(250, estimate.defaultToyLineLength());
      });

      test('750 if acres is 10 (250 base + 50 per acre)', () {
        Estimate estimate = Estimate(acres: 10);
        expect(750, estimate.defaultToyLineLength());
      });
    });

    group("defaultFittings", () {
      test('5 when there are no acres (one hundredth of Latline truncated)',
          () {
        Estimate estimate = Estimate(acres: 0);
        expect(5, estimate.defaultFittings());
      });

      test(
          '15 when there is exactly 10 acres (one hundredth of Latline truncated)',
          () {
        Estimate estimate = Estimate(acres: 10);
        expect(15, estimate.defaultFittings());
      });

      test(
          '105 when there is exactly 100 acres (one hundredth of Latline truncated)',
          () {
        Estimate estimate = Estimate(acres: 100);
        expect(105, estimate.defaultFittings());
      });
    });

    // Fold-a-Tank Acres
    group('defaultFoldaTankAcres', () {
      test('0 when acres are less than 10', () {
        Estimate estimate = Estimate(acres: 0);
        expect(estimate.defaultFoldaTanksAcres(), 0);
      });
      test('2 when acres are equal to 10', () {
        Estimate estimate = Estimate(acres: 10);
        expect(estimate.defaultFoldaTanksAcres(), 2);
      });
      test('1 for every 5 acres', () {
        Estimate estimate = Estimate(acres: 24);
        expect(estimate.defaultFoldaTanksAcres(), 4);
      });
    });

    // Mark 3 Pumps Acres
    group('defaultMark3PumpsAcres', () {
      test('0 when acres are less than 10', () {
        Estimate estimate = Estimate(acres: 0);
        expect(estimate.defaultMark3PumpsAcres(), 0);
      });
      test('1 when acres are equal to 10', () {
        Estimate estimate = Estimate(acres: 10);
        expect(estimate.defaultMark3PumpsAcres(), 1);
      });
      test('1 for every 10 acres', () {
        Estimate estimate = Estimate(acres: 24);
        expect(estimate.defaultMark3PumpsAcres(), 2);
      });
    });

    // Mark 3 kits acres
    group('calculateMark3KitsAcres', () {
      test('0 when acres are less than 10', () {
        Estimate estimate = Estimate(acres: 0);
        expect(estimate.calculateMark3KitsAcres(), 0);
      });
      test('1 when acres are equal to 10', () {
        Estimate estimate = Estimate(acres: 10);
        expect(estimate.calculateMark3KitsAcres(), 1);
      });
      test('1 for every 10 acres', () {
        Estimate estimate = Estimate(acres: 24);
        expect(estimate.calculateMark3KitsAcres(), 2);
      });
    });

    //  Mark 3 Pump Mix Cans
    group('defaultPumpMixCansAcres', () {
      test('0 when acres are less than 10', () {
        Estimate estimate = Estimate(acres: 0);
        expect(estimate.defaultPumpMixCansAcres(), 0);
      });
      test('6 when acres are equal to 10', () {
        Estimate estimate = Estimate(acres: 10);
        expect(estimate.defaultPumpMixCansAcres(), 6);
      });
      test('6 for every 10 acres', () {
        Estimate estimate = Estimate(acres: 42);
        expect(estimate.defaultPumpMixCansAcres(), 24);
      });
    });

    // Water Pallets
    group('defaultWaterPallets', () {
      test('0 when acres are less than 20', () {
        Estimate estimate = Estimate(acres: 0);
        expect(estimate.defaultWaterPallets(), 0);
      });
      test('1 when acres are equal to 20', () {
        Estimate estimate = Estimate(acres: 20);
        expect(estimate.defaultWaterPallets(), 1);
      });
      test('1 for every 20 acres', () {
        Estimate estimate = Estimate(acres: 42);
        expect(estimate.defaultWaterPallets(), 2);
      });
    });

    // Gatorade Pallets
    group('defaultGatoradePallets', () {
      test('0 when acres are less than 20', () {
        Estimate estimate = Estimate(acres: 0);
        expect(estimate.defaultGatoradePallets(), 0);
      });
      test('1 when acres are equal 20', () {
        Estimate estimate = Estimate(acres: 20);
        expect(estimate.defaultGatoradePallets(), 1);
      });
      test('1 for every 20 acres', () {
        Estimate estimate = Estimate(acres: 42);
        expect(estimate.defaultGatoradePallets(), 2);
      });
    });

    // MRE Pallets
    group('defaultMrePallets', () {
      test('0 when acres are less than 20', () {
        Estimate estimate = Estimate(acres: 0);
        expect(estimate.defaultMrePallets(), 0);
      });

      test('1 when acres are 20', () {
        Estimate estimate = Estimate(acres: 20);
        expect(estimate.defaultMrePallets(), 1);
      });

      test('One for every 20 acres', () {
        Estimate estimate = Estimate(acres: 42);
        expect(estimate.defaultMrePallets(), 2);
      });
    });

    // PortaPotties
    group('defaultPortaPottiesAcres', () {
      test('0 when acres are 0', () {
        Estimate estimate = Estimate(acres: 0);
        expect(estimate.defaultPortaPottiesAcres(), 0);
      });
      test('2 when acres are 20', () {
        Estimate estimate = Estimate(acres: 20);
        expect(estimate.defaultPortaPottiesAcres(), 2);
      });
      test('3 when acres are 32', () {
        Estimate estimate = Estimate(acres: 32);
        expect(estimate.defaultPortaPottiesAcres(), 3);
      });
      test('4 when acres are 48', () {
        Estimate estimate = Estimate(acres: 48);
        expect(estimate.defaultPortaPottiesAcres(), 4);
      });
    });

    // STRUCTURE TESTS BELOW
    //Sprinklers

    group('defaultSprinklerKits', () {
      test('0 when there are no structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 0);
        expect(estimate.defaultSprinklerKits(), 0);
      });

      test(' Structures < 10 -> Sprinkler = 4 ', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultSprinklerKits(), 4);
      });
      test('4 when there are exactly 10 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultSprinklerKits(), 4);
      });

      test('10 when there are between 10 and 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 20);
        expect(estimate.defaultSprinklerKits(), 10);
      });
      test('10 when there are 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 40);
        expect(estimate.defaultSprinklerKits(), 10);
      });
      test('13 when there are greater than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 50);
        expect(estimate.defaultSprinklerKits(), 13);
      });
    });

    // OnePointFive Inch Hose
    group('defaultOnePointFiveInchHose', () {
      test('0 when there are no structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 0);
        expect(estimate.defaultOnePointFiveHose(), 0);
      });
      test('3000 when there 0 to 10 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultOnePointFiveHose(), 3000);
      });
      test('5000 when there are exactly 10 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 10);
        expect(estimate.defaultOnePointFiveHose(), 5000);
      });
      test('5000 when there are 10 to 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 20);
        expect(estimate.defaultOnePointFiveHose(), 5000);
      });
      test('5000 when there are exactly 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 40);
        expect(estimate.defaultOnePointFiveHose(), 5000);
      });
      test('7000 when there are greater than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 50);
        expect(estimate.defaultOnePointFiveHose(), 7000);
      });
    });

    // One Inch Hose
    group('defaultOneInchHose', () {
      test('0 when there are no structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 0);
        expect(estimate.defaultOneInchHose(), equals(0));
      });
      test('20 when there is less than 10 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultOneInchHose(), equals(20));
      });
      test('35 when there is less than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 30);
        expect(estimate.defaultOneInchHose(), equals(35));
      });
      test('35 when there is exactly 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 40);
        expect(estimate.defaultOneInchHose(), equals(35));
      });
      test('50 when there is more than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 50);
        expect(estimate.defaultOneInchHose(), equals(50));
      });
    });

    // One Point Five Wye
    group('defaultOnePointFiveWye', () {
      test('0 when there are no structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 0);
        expect(estimate.defaultOnePointFiveWye(), equals(0));
      });
      test('10 when there is less than 10 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultOnePointFiveWye(), equals(10));
      });
      test('40 when there is less than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 30);
        expect(estimate.defaultOnePointFiveWye(), equals(40));
      });
      test('40 when there is exactly 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 40);
        expect(estimate.defaultOnePointFiveWye(), equals(40));
      });
      test('50 when there is more than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 50);
        expect(estimate.defaultOnePointFiveWye(), equals(50));
      });
    });

    // One Inch Wye
    group('defaultOneInchWye', () {
      test('0 when there are no structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 0);
        expect(estimate.defaultOneInchWye(), equals(0));
      });
      test('20 when there is less than 10 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultOneInchWye(), equals(20));
      });
      test('40 when there is less than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 30);
        expect(estimate.defaultOneInchWye(), equals(40));
      });
      test('40 when there is exactly 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 40);
        expect(estimate.defaultOneInchWye(), equals(40));
      });
      test('50 when there is more than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 50);
        expect(estimate.defaultOneInchWye(), equals(50));
      });
    });

    // OnePointFiveToOneInchReducer
    group('defaultOnePointFiveToOneInchReducer', () {
      test('0 when there is no structure', () {
        Estimate estimate = Estimate(acres: 0, structures: 0);
        expect(estimate.defaultOnePointFiveToOneInchReducer(), equals(0));
      });

      test('20 when there is less than 10 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultOnePointFiveToOneInchReducer(), equals(20));
      });
      test('20 when there is exactly  10 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 10);
        expect(estimate.defaultOnePointFiveToOneInchReducer(), equals(20));
      });

      test('20 when there is less than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 30);
        expect(estimate.defaultOnePointFiveToOneInchReducer(), equals(20));
      });
      test('20 when there is exactly  40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultOnePointFiveToOneInchReducer(), equals(20));
      });
      test('30 when there is more than 40 structures ', () {
        Estimate estimate = Estimate(acres: 0, structures: 55);
        expect(estimate.defaultOnePointFiveToOneInchReducer(), equals(30));
      });
    });

    // KK Nozzles
    group('defaultKKNozzles', () {
      test('0 When there are no structure', () {
        Estimate estimate = Estimate(acres: 0, structures: 0);
        expect(estimate.defaultKkNozzles(), equals(0));
      });

      test('20 When there is less than 40 structures ', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultKkNozzles(), equals(20));
      });

      test('20 When there is exactly 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 40);
        expect(estimate.defaultKkNozzles(), equals(20));
      });

      test('30 When there is more than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 50);
        expect(estimate.defaultKkNozzles(), equals(30));
      });
    });

    // Mark 3 Structures
    group('defaultMark3Structures', () {
      test('Default Mark3Structures - Structures: 0', () {
        Estimate estimate = Estimate(acres: 0, structures: 0);
        expect(estimate.defaultMark3Structures(), equals(0));
      });

      test('Default Mark3Structures - Structures: 0 < x < 10 ', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultMark3Structures(), equals(3));
      });

      test('Default Mark3Structures - Structures: 10 < x < 40 ', () {
        Estimate estimate = Estimate(acres: 0, structures: 20);
        expect(estimate.defaultMark3Structures(), equals(6));
      });

      test('Default Mark3Structures - Structures: x > 40 ', () {
        Estimate estimate = Estimate(acres: 0, structures: 50);
        expect(estimate.defaultMark3Structures(), equals(10));
      });
    });

    // Unleaded Gas
    group('defaultUnleadedGas', () {
      test('Default Unleaded Gas - Structures: x < 10', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultUnleadedGas(), equals(30));
      });

      test('Default Unleaded Gas - Structures: 10 < x < 40', () {
        Estimate estimate = Estimate(acres: 0, structures: 20);
        expect(estimate.defaultUnleadedGas(), equals(90));
      });

      test('Default Unleaded Gas - Structures: x > 40', () {
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
        expect(estimate.defaultTwoCycleOil(), equals(18));
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
    group('defaultPortaPottiesStructures', () {
      test('0 when there are no structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 0);
        expect(estimate.defaultPortaPottiesStructures(), equals(0));
      });
      test('5 when there is less than 10 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 5);
        expect(estimate.defaultPortaPottiesStructures(), equals(5));
      });
      test('6 when there is less than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 30);
        expect(estimate.defaultPortaPottiesStructures(), equals(6));
      });
      test('10 when there is exactly 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 40);
        expect(estimate.defaultPortaPottiesStructures(), equals(6));
      });
      test('10 when there is more than 40 structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 50);
        expect(estimate.defaultPortaPottiesStructures(), equals(10));
      });
    });

    group("defaultFoldATankStructures", () {
      test('0 when there are no structures', () {
        Estimate estimate = Estimate(acres: 0, structures: 0);
        expect(0, estimate.defaultFoldATankStructures());
      });
      test(
          '16 when there are 21 structures (one fifth of structures truncated, times 4)',
          () {
        Estimate estimate = Estimate(acres: 0, structures: 21);
        expect(16, estimate.defaultFoldATankStructures());
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
