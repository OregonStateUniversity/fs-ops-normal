
String timeFormat(){
  DateTime now = DateTime.now().toLocal();
  now = now.toLocal();
  String date = "${now.month}-${now.day}-${now.year} at ${now.hour}:${now.minute}:${now.second}";

  return date;
}