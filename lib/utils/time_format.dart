import 'package:intl/intl.dart';

const FULL_DATE_AND_TIME_FORMAT = "dd/MM/yyyy HH:mm:ss";

class TimeFormat {
  static var format = new DateFormat(FULL_DATE_AND_TIME_FORMAT);

  static get currentTime {
    return format.format(DateTime.now());
  }
}
