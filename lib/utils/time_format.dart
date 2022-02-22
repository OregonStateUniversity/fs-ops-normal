import 'package:intl/intl.dart';

class TimeFormat {
  static var format = new DateFormat("dd/MM/yyyy HH:mm:ss");

  static get currentTime {
    return DateFormat.jm().format(DateTime.now());
  }
}
