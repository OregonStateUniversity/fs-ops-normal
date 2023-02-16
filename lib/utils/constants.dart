class Constants {
  final String wiredashID;
  final String wiredashSecret;

  Constants({this.wiredashID = "", this.wiredashSecret = ""});

  factory Constants.fromJson(Map<String, dynamic> jsonMap) {
    return new Constants(
        wiredashID: jsonMap["wiredash_id"],
        wiredashSecret: jsonMap["wiredash_secret"]);
  }
}
