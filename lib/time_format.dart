import 'package:intl/intl.dart';

class TimeFormat{
  static var format = new DateFormat("dd/MM/yyyy HH:mm");

  String getTime(){
    DateTime now = new DateTime.now();
    var date = format.format(now);
    return date;
  }
}