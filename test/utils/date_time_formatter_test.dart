import 'package:flutter_test/flutter_test.dart';
import 'package:ops_normal/utils/date_time_formatter.dart';

void main() {
  group('Time', () {
    test('create new time', () {
      DateTime now = DateTime.parse('1969-07-20 20:18:04Z');
      var expected = DateTimeFormatter.format(now);
      expect('20/07/1969 20:18:04', equals(expected));
    });
  });
}
