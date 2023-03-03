import 'dart:core';

///Function: convertToMS
///Descriptiop: converts decimal degree to hour-minute-seconds. Used to convert
///             latitude, longitude
String convertToMS(double? decimalNum) {
  int hour = decimalNum!.toInt();
  double remainder = (decimalNum - hour) * 60;
  int minutes = remainder.toInt();
  remainder = (remainder - minutes) * 60;
  int seconds = remainder.toInt();
  return "$hour˚ $minutes.$seconds'";
}
