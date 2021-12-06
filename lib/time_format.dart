import 'package:intl/intl.dart';

class TimeFormat{
  static var format = new DateFormat("dd/MM/yyyy HH:mm:ss");

  static get currentTime{
    DateTime now = new DateTime.now();
    var date = format.format(now);
    return date;
  }
}