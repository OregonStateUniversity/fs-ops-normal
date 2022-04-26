import 'package:intl/intl.dart';

const FULL_DATE_AND_TIME_FORMAT = "dd/MM/yyyy HH:mm:ss";

class DateTimeFormatter {
  static final formatter = DateFormat(FULL_DATE_AND_TIME_FORMAT);

  static String format(DateTime dateTime) {
    return formatter.format(dateTime);
  }

}
