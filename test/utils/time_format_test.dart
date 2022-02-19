import 'package:flutter_test/flutter_test.dart';
import 'package:hose_jockey/utils/time_format.dart';

void main() {
  group('Time', () {
    test('create new time', () {
      DateTime now = DateTime.now();
      var format = TimeFormat.format; // dd/MM/yyyy HH:mm
      var expected = format.format(now);
      String actual = TimeFormat.currentTime;
      expect(actual, equals(expected));
    });
  });
}
