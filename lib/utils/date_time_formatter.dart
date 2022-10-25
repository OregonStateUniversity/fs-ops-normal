import 'package:intl/intl.dart';

const fullDateAndTimeFormat = "dd/MM/yyyy HH:mm:ss";

class DateTimeFormatter {
  static final formatter = DateFormat(fullDateAndTimeFormat);

  static String format(DateTime dateTime) {
    return formatter.format(dateTime);
  }

}
