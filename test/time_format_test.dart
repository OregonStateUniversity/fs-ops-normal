import 'package:flutter_test/flutter_test.dart';
import  'package:hose_jockey/time_format.dart';

void main() {
  group('An string of time', () {

    test('create new time', (){
      //Arrange
      DateTime now = DateTime.now();
      var format = TimeFormat.format;
      var expected = format.format(now);

      //Act
      String actual = TimeFormat().getTime();

      //Assert
      expect(actual, equals(expected));
    });
  });
}