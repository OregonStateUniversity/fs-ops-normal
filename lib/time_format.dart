
String timeFormat(){
  DateTime now = DateTime.now().toLocal();
  now = now.toLocal();
  var h = now.hour < 10 ? "0" + now.hour.toString() : now.hour.toString();
  var m = now.minute < 10 ? "0" + now.minute.toString() : now.minute.toString();
  var s = now.second < 10 ? "0" + now.second.toString() : now.second.toString();
  var month = now.month < 10 ? "0" + now.month.toString() : now.month.toString();
  var day = now.day < 10 ? "0" + now.day.toString() : now.day.toString();

  String date = "$month-$day-${now.year} at $h:$m:$s";

  return date;
}