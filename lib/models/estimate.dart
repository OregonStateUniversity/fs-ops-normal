class Estimate1{
  static const BASE_TRUNK_LINE_LENGTH = 1000;
  static const TRUNK_LINE_LENGTH_PER_ACRE = 200;

  final name;
  final String timeStamp;
  final int acres;

  Estimate1({this.name, this.acres, this.timeStamp});

  int get trunkLineLength => BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres;

  int get latLineLength => trunkLineLength ~/ 2;

  int get toyLineLength => latLineLength ~/ 2;

}


class Estimate{
  static const BASE_TRUNK_LINE_LENGTH = 1000;
  static const TRUNK_LINE_LENGTH_PER_ACRE = 200;

  String name;
  String timeStamp;
  int acres;

  int _trunkLineLength;
  int _latLineLength;
  int _toyLineLength;

  Estimate({this.name = "NoNameNeeded", this.acres, this.timeStamp});

  Estimate.jsonConvF(name, acres, timeStamp, trunk, lat, toy){
    name = name;
    acres = acres;
    timeStamp = timeStamp;
    _trunkLineLength = trunk;
    _latLineLength = lat;
    _toyLineLength = toy;
  }

  Estimate.loadSavedEstimate(this.name, this.acres, this.timeStamp, trunk, lat, toy){
    _trunkLineLength = trunk;
    _latLineLength = lat;
    _toyLineLength = toy;
  }

  void initialLineCalculation(){
    _trunkLineLength = BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres;
    _latLineLength = trunkLineLength ~/ 2;
    _toyLineLength = latLineLength ~/ 2;
  }

  int get trunkLineLength => _trunkLineLength;
  int get latLineLength => _latLineLength;
  int get toyLineLength => _toyLineLength;

  set trunkLineLength(int length) => _trunkLineLength;
  set latLineLength(int length) => _latLineLength;
  set toyLineLength(int length) => _toyLineLength;

  factory Estimate.fromJson(Map<String, dynamic> json) => Estimate.jsonConvF(
    json["name"],
    json["acre"],
    json["timeStamp"],
    json["trunkLineLength"],
    json["latLineLength"],
    json["toyLineLength"],
  );

  Map<String, dynamic> toJson() =>{
    'name': name,
    'acres': acres,
    'timeStamp': timeStamp,
    'trunkLineLength': trunkLineLength,
    'latLineLength': latLineLength,
    'toyLineLength': toyLineLength
  };

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'name': name,
      'timeStamp': timeStamp,
      'acres': acres,
      'trunkLineLength': _trunkLineLength,
      'latLineLength': _latLineLength,
      'toyLineLength': _toyLineLength,
    };
    return map;
  }

  Estimate.fromMap(Map<String, dynamic> map){
    name = map['name'];
    timeStamp = map['timeStamp'];
    acres = map['acres'];
    _trunkLineLength = map['trunkLineLength'];
    _latLineLength = map['layLineLength'];
    _toyLineLength = map['toyLineLength'];
  }
}
