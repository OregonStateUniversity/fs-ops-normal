import 'package:test/test.dart';
import 'package:hose_jockey/models/engagement.dart';
import 'package:hose_jockey/models/estimate.dart';

void main() {

  group('An Engagement', () {

    test('constructor with empty order list', () {
      //Arrange
      List<Estimate> estimates = <Estimate>[];

      //Act
      Engagement engagement = new Engagement("Test", "Time", 15, "Sqaure", "Timber", 0, estimates, 1);

      //Assert
      expect(engagement.active, equals(1));
      expect(engagement.name, equals("Test"));
      expect(engagement.timeStamp, equals("Time"));
      expect(engagement.size, equals(15));
      expect(engagement.shape, equals("Square"));
      expect(engagement.type, equals("Timber"));
      expect(engagement.orders, equals(estimates));
    });

    test('constructor with orders in list', () {
      //Arrange
      List<Estimate> estimates = <Estimate>[];
      Estimate estimate = new Estimate();
      estimate.acres = 1;
      estimates.add(estimate);

      //Act
      Engagement engagement = new Engagement("Test", "Time", 15, "Sqaure", "Timber", 0, estimates, 1);

      //Assert
      expect(engagement.active, equals(1));
      expect(engagement.name, equals("Test"));
      expect(engagement.timeStamp, equals("Time"));
      expect(engagement.size, equals(15));
      expect(engagement.shape, equals("Square"));
      expect(engagement.type, equals("Timber"));
      expect(engagement.orders, equals(estimates));
    });

    test('toString', () {
      //Arrange
      Engagement engagement = new Engagement("Test", "Time", 15, "Sqaure", "Timber", 0, [], 1);
      String expected = "{ Test, Time, 15, Square, Timber }";

      //Act
      String actual = engagement.toString();

      //Assert
      expect(actual, equals(expected));

    });
  });
}