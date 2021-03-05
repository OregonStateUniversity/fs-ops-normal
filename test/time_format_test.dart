import 'package:flutter_test/flutter_test.dart';
import  'package:hose_jockey/time_format.dart';

void main() {
  group('Time', () {

    test('create new time', (){

      //Arrange
      DateTime now = DateTime.now();
      var format = TimeFormat.format; // dd/MM/yyyy HH:mm
      var expected = format.format(now);

      //Act
      String actual = TimeFormat().getTime();

      //Assert
      expect(actual, equals(expected));
    });
  });
}