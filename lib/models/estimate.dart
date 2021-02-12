class Estimate{
  static const BASE_TRUNK_LINE_LENGTH = 1000;
  static const TRUNK_LINE_LENGTH_PER_ACRE = 200;

  String name;
  String timeStamp;
  int acres;

  int _trunkLineLength;
  int _latLineLength;
  int _toyLineLength;
  int _fittings;

  Estimate({this.name = "NoNameNeeded", this.acres, this.timeStamp});

  @override
  String toCopyString(){
    String str =
        "Trunk Line: ${this.trunkLineLength} ft.\n"
        "Lat Line: ${this.latLineLength} ft.\n"
        "Toy Hose: ${this.toyLineLength} ft.\n\n";

    if(this.fittings >= 0){
      str +=
          "1.5\" Gated Wye:${this.fittings}\n"
          "1.5\" Reducers:${this.fittings}\n"
          "1\"-3/4\" Reducers: ${this.fittings}\n"
          "Forester Nozzles: ${this.fittings}\n"
          "Toy Nozzles: ${this.fittings}\n"
          "Toy Wye: ${this.fittings}\n\n";
    }
    if(this.acres >= 10){
      str +=
          "Folda-tank: ${acres ~/ 5}\n"
          "Mark 3 + Kits: ${acres ~/ 5}\n"
          "Pump Mix (Gallons): ${((acres ~/ 5) ~/ 2) * 3}\n\n";
    }
    if(this.acres >= 20){
      str +=
            "Water (Pallets): ${acres ~/ 20}\n"
            "Gatorade (Pallets): ${acres ~/ 20}\n"
            "MRE (Pallets): ${acres ~/ 20}\n"
            "Port-a-Potties: ${acres ~/ 2}\n\n";

    }
    return str;
  }

  Estimate.jsonConvF(name, acres, timeStamp, trunk, lat, toy, [fittings = 0]){
    this.name = name;
    this.acres = acres;
    this.timeStamp = timeStamp;
    _trunkLineLength = trunk;
    _latLineLength = lat;
    _toyLineLength = toy;
    _fittings = fittings;
  }

  Estimate.loadSavedEstimate(name, acres, timeStamp, trunk, lat, toy, [fittings = 0]){
    this.name = name;
    this.acres = acres;
    this.timeStamp = timeStamp;
    _trunkLineLength = trunk;
    _latLineLength = lat;
    _toyLineLength = toy;
    _fittings = fittings;
  }

  void initialLineCalculation(){
    _trunkLineLength = BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres;
    _latLineLength = trunkLineLength ~/ 2;
    _toyLineLength = latLineLength ~/ 2;
    _fittings = latLineLength ~/ 100;
  }

  int get trunkLineLength => _trunkLineLength;
  int get latLineLength => _latLineLength;
  int get toyLineLength => _toyLineLength;
  int get fittings => _fittings;

  set trunkLineLength(int length) => _trunkLineLength;
  set latLineLength(int length) => _latLineLength;
  set toyLineLength(int length) => _toyLineLength;
  set fittings(int count) => _fittings;

  factory Estimate.fromJson(Map<String, dynamic> json) => Estimate.jsonConvF(
    json["name"],
    json["acres"],
    json["timeStamp"],
    json["trunkLineLength"],
    json["latLineLength"],
    json["toyLineLength"],
    json["fittings"] == null ? 0 : json["fittings"]
  );

  Map<String, dynamic> toJson() =>{
    'name': name,
    'acres': acres,
    'timeStamp': timeStamp,
    'trunkLineLength': trunkLineLength,
    'latLineLength': latLineLength,
    'toyLineLength': toyLineLength,
    'fittings' : fittings
  };
}
